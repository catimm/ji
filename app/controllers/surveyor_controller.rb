# encoding: UTF-8

module SurveyorControllerCustomMethods
  
  def self.included(base)
    # base.send :before_filter, :require_user   # AuthLogic
    # base.send :before_filter, :login_required  # Restful Authentication
    base.send :layout, 'surveyor_custom'
  end

  # Actions
  def new
    super
    # @title = "You can take these surveys"
  end
  def create
    exploration_user_id = params[:exploration_users_id]
    if session[:exploration_users_id].nil?
      cookies[:exploration_users_id] = exploration_user_id
    end
    
    exploration_user = ExplorationUser.where(id: exploration_user_id).pluck(:status)
    status = exploration_user[0]

    if status == 1
      ExplorationUser.update(exploration_user_id, :status => '2')
    end
    
    if status == 6
      ExplorationUser.update(exploration_user_id, :status => '7')
    end
    
    surveys = Survey.where(:access_code => params[:survey_code]).order("survey_version DESC")
      if params[:survey_version].blank?
        @survey = surveys.first
      else
        @survey = surveys.where(:survey_version => params[:survey_version]).first
      end
      @response_set = ResponseSet.
        create(:survey => @survey, :user_id => exploration_user_id) #using exploration_user_id instead of user_id, but exploration_user_id has the user_id
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
    Rails.logger.debug("Surveyor Initial Update Sesssion is: #{session[:exploration_users_id].inspect}")
    step_title = params[:survey_code]
    if step_title == "craft-beer-input"
      session[:finish_path] = step4_path
    end
    if step_title == "craft-beer-demographics"
      session[:finish_path] = step9_path
    end
    super
    response_set = ResponseSet.where(access_code: params[:response_set_code]).pluck(:user_id)
    session[:exploration_users_id] = response_set[0]
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
