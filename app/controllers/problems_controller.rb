class ProblemsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    # If session for exploration id doesn't exist, set exploration id as session parameter until replaced
    if !session[:exploration_id]
      session[:exploration_id] = params[:exploration_id]
    end
    # Grab exploration data from params for view variables
    @exploration = Exploration.find(session[:exploration_id])
    Rails.logger.debug("Exploration info: #{@exploration.inspect}")
    # Find if current user is already participating in this exploration
    @exploration_user = ExplorationUser.where(exploration_id: @exploration.id, user_id: current_user.id)[0]
    Rails.logger.debug("Exploration user info: #{@exploration_user.inspect}")
    # Find user current step if this user is participating
    if !@exploration_user.nil?
      @step = @exploration_user.status
      Rails.logger.debug("Current step: #{@step.inspect}")
    end
    # Find explorer(s) who own this project
    @explorers = Explorer.where(exploration_id: @exploration.id)
    Rails.logger.debug("Explorer info: #{@explorers.inspect}")
    # If current user is a project owner, set variable to "yes" -- for final/inviation step
    if @explorers.include? current_user
      @owner = "yes"
    else
      @owner = "no"
    end
    @explorer_lead = @explorers.where(lead_explorer: "yes")[0]
    Rails.logger.debug("Explorer Lead #{@explorer_lead.inspect}")
    # Create written input form for steps that use that
    @written = WrittenInput.new
    # Pass variables to problem.js.erb
    gon.current_user = current_user.id
    gon.exploration_id = @exploration.id
    gon.step = @step
    # Create problems variable for dynamic input in various steps
    @problems = Problem.where(exploration_id: @exploration.id)[0]
    Rails.logger.debug("Problems data: #{@problems.inspect}")
    # Set current problem id as session varialbe
    session[:problem_id] = @problems.id
    # Set time variable
    @time = Time.now
    # Create User variable for new user invite in final step
    @user = User.new
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
    elsif @step == "first" 
      ExplorationUser.update(@exploration_user.id, :status => "second")
    elsif @step == "second"
      ExplorationUser.update(@exploration_user.id, :status => "third")
    elsif @step == "third" 
      ExplorationUser.update(@exploration_user.id, :status => "finished",:completed => @time)
    else
    end
    
    # Return to Show action to show project page again    
    redirect_to exploration_problem_path(@exploration_id, @problem_id)
  end
end