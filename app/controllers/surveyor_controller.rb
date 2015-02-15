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
    exploration_user = ExplorationUser.where(id: exploration_user_id).all.to_a
    status = exploration_user.first.status

    if status == 1
      ExplorationUser.update(exploration_user_id, :status => '2')
    end
    
    if status == 6
      ExplorationUser.update(exploration_user_id, :status => '7')
    end
    Rails.logger.debug("Step is: #{@step.inspect}")
    super
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
    step_title = params[:survey_code]
    if step_title == "craft-beer-input"
      session[:finish_path] = step4_path
    end
    if step_title == "craft-beer-demographics"
      session[:finish_path] = step9_path
    end
    super
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
