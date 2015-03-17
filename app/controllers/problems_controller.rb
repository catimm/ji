class ProblemsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    # First make sure params contains current exploration id. If not, use the session variable to get Exploration data [This should be the case only when moving between steps using the step guide links]
    if !params.has_key?(:exploration_id)
        @exploration = Exploration.find(session[:exploration_id])
    else
    # If params has exploration id, use it to grab exploration data and then save to new session variable [This should be the standard case]
      @exploration = Exploration.find(params[:exploration_id])
      Rails.logger.debug("Exploration info: #{@exploration.inspect}")
      session[:exploration_id] = params[:exploration_id]
    end
    # Find if current user is already participating in this exploration
    @exploration_user = ExplorationUser.where(exploration_id: @exploration.id, user_id: current_user.id)[0]
    Rails.logger.debug("Exploration user info: #{@exploration_user.inspect}")
    # Check if exploration user exists
    if @exploration_user.nil?
      @exploration_user = ExplorationUser.new(:exploration_id => @exploration.id, :user_id => current_user.id, :status => 0, 
      :user_chosen => "no")
      @exploration_user.save!
      Rails.logger.debug("Exploration info: #{@exploration_user.inspect}")
    end
    # Grab current user's current step
    @step = @exploration_user.status
    Rails.logger.debug("Current step: #{@step.inspect}")
    # Find explorer(s) who own this project
    @explorers = Explorer.where(exploration_id: @exploration.id)
    Rails.logger.debug("Explorer info: #{@explorers.inspect}")
    # Pull IDs of explorers
    @explorers_id = @explorers.pluck(:id)
    Rails.logger.debug("Explorer IDs: #{@explorers_id.inspect}")
    # If current user is a project owner, set variable to "yes" -- for final/inviation step
    if @explorers_id.include? current_user.id
      @owner = "yes"
    else
      @owner = "no"
    end
    Rails.logger.debug("Explorer is a lead: #{@owner.inspect}")
    @explorer_lead = @explorers.where(lead_explorer: "yes")[0]
    Rails.logger.debug("Explorer Lead #{@explorer_lead.inspect}")
    # Create written input form for steps that use that
    @written = WrittenInput.new
    # Create problems variable for dynamic input in various steps
    @problems = Problem.where(exploration_id: @exploration.id)[0]
    Rails.logger.debug("Problems data: #{@problems.inspect}")
    # Set current problem id as session varialbe
    session[:problem_id] = @problems.id
    # Set time variable
    @time = Time.now
    # Create User variable for new user invite in final step
    @user = User.new
    @view = params[:step]
    Rails.logger.debug("View is: #{@view.inspect}")
    # Check if @vivew is nil and if so, make it equal @step
    if !params.has_key?(:step)
      @view = @step
    end
    Rails.logger.debug("View is now: #{@view.inspect}")
    if @view == "finished"
      render "problems/finished" and return
    elsif @view == "third" 
      render "problems/third" and return
    elsif @view == "second"
      render "problems/second" and return
    elsif @view == "first" 
      render "problems/first" and return
    else
    end
    
    # Pass variables to problem.js.erb
    gon.current_user = current_user.id
    gon.exploration_id = @exploration.id
    gon.problem_id = @problems.id
    gon.step = @step
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def update
    # Set time variable
    @time = Time.now
    # Grab params data
    @exploration_id = params[:exploration_id]
    @problem_id = params[:id]
    # Use params data to grab database data
    @exploration_user = ExplorationUser.where(exploration_id: @exploration_id, user_id: current_user.id)[0]
    @step = @exploration_user.status
    Rails.logger.debug("Step in update is: #{@step.inspect}")
    # Use params and database data to update written input if some is provided
    # First check if params exist--in case where coming from Show view, there won't be params . . .
    if params.has_key?(:textInputArea)
      # Insert written input if any exists
      if !params[:textInputArea].empty?
        new_input = WrittenInput.new(:user_id => @exploration_user.user_id, :exploration_id => @exploration_id, :written_input => params[:textInputArea], :step => @step)
        new_input.save!
      end
    end
    # update the status of the Exploration User
    if @step == "0"
      ExplorationUser.update(@exploration_user.id, :status => "first", :started => @time, :user_chosen => "yes")
      session[:next_step_path] = pfirst_path(@exploration_id, @problem_id, "first")
    elsif @step == "first" 
      ExplorationUser.update(@exploration_user.id, :status => "second")
      session[:next_step_path] = psecond_path(@exploration_id, @problem_id, "second")
    elsif @step == "second"
      ExplorationUser.update(@exploration_user.id, :status => "third")
      session[:next_step_path] = pthird_path(@exploration_id, @problem_id, "third")
    elsif @step == "third" 
      ExplorationUser.update(@exploration_user.id, :status => "finished",:completed => @time)
      session[:next_step_path] = pfinished_path(@exploration_id, @problem_id, "finished")
    else
    end
    
    # Return to Show action to show project page again    
    redirect_to next_step_path
  end
  
  def next_step_path
    session[:next_step_path]
  end
end