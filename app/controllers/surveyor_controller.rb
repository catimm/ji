# encoding: UTF-8

module SurveyorControllerCustomMethods
  
  def self.included(base)
    # base.send :before_filter, :require_user   # AuthLogic
    # base.send :before_filter, :login_required  # Restful Authentication
    base.send :layout, '_surveyor'
  end

  # Actions
  def new
    super
    # @title = "You can take these surveys"
  end
  def create
    # Keep the status updated in ExplorationUser
    @exploration_user_id = ExplorationUser.find(params[:exploration_user_id])
    Rails.logger.debug("Surveyor Initial Create Sesssion ID is: #{@exploration_user_id.inspect}")
    status = params[:status]
    Rails.logger.debug("Surveyor Initial Create Sesssion Status is: #{status.inspect}")

    if status == "second"
      ExplorationUser.update(@exploration_user_id.id, :status => 'third')
    end
    
    if status == "seventh"
      ExplorationUser.update(@exploration_user_id.id, :status => 'eighth')
    end
    
    # Check if params exist--in case where coming from Show view, there won't be params . . .
    if params.has_key?(:textInputArea)
      # Insert written input if any exists
      if !params[:textInputArea].empty?
        new_input = WrittenInput.new(:user_id => @exploration_user_id.user_id, :exploration_id => @exploration_user_id.exploration_id, :written_input => params[:textInputArea], :step => status)
        new_input.save!
      end
    end
    
    # Original code from Surveyor
    surveys = Survey.where(:access_code => params[:survey_code]).order("survey_version DESC")
      if params[:survey_version].blank?
        @survey = surveys.first
      else
        @survey = surveys.where(:survey_version => params[:survey_version]).first
      end
      @response_set = ResponseSet.
        create(:survey => @survey, :user_id => @exploration_user_id.id) #using exploration_user_id instead of user_id, but exploration_user_id has the user_id
      if (@survey && @response_set)
        flash[:notice] = t('surveyor.survey_started_success')
        redirect_to(surveyor.edit_my_survey_path(
          :survey_code => @survey.access_code, :response_set_code  => @response_set.access_code))
      else
        flash[:notice] = t('surveyor.Unable_to_find_that_survey')
        redirect_to surveyor_index
      end

  end
  def show
    super
  end
  def edit
    step_title = params[:survey_code]
    if step_title == "craft-beer-input"
      @step = "Step 3 of 8: Craft beer questions"
      @button_title = "surveyor.step3"
    end
    if step_title == "craft-beer-demographics"
      @step = "Step 7 of 8: About you"
      @button_title = "surveyor.step7"
    end
    super
  end
  def update
    
    @exploration_user_id = ResponseSet.where(access_code: params[:response_set_code]).pluck(:user_id)[0]
    Rails.logger.debug("Surveyor Initial Update User ID is: #{@exploration_user_id.inspect}")
    @exploration = ExplorationUser.find(@exploration_user_id)
    Rails.logger.debug("Exploration info is: #{@exploration.inspect}")
    @problem = Problem.where(exploration_id: @exploration.exploration_id).pluck(:id)[0]
    Rails.logger.debug("Problem info is: #{@problem.inspect}")
    # Original code from Surveyor
    question_ids_for_dependencies = (params[:r] || []).map{|k,v| v["question_id"] }.compact.uniq 
    saved = load_and_update_response_set_with_retries 
    
    redirect_to project_update_from_survey_path(@exploration.exploration_id, @problem) and return 
     
  end

  # Paths
  def surveyor_index
    # most of the above actions redirect to this method
    super # surveyor.available_surveys_path
  end
  def surveyor_finish
    session[:finish_path]
  end
end
class SurveyorController < ApplicationController
  include Surveyor::SurveyorControllerMethods
  include SurveyorControllerCustomMethods
end
