class ProblemsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    # Grab exploration data from params for view variables
    @exploration = Exploration.find(params[:exploration_id])
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
    @explorer_lead = @explorers.where(lead_explorer: "yes")[0]
    Rails.logger.debug("Explorer Lead #{@explorer_lead.inspect}")
    # Create written input form for steps that use that
    @written = WrittenInput.new
    # Pass variables to problem.js.erb
    gon.current_user = current_user.id
    gon.exploration_id = @exploration.id
    gon.step = @step
    # Create problems variable for dynamic input in various steps
    @problems = Problem.where(exploration_id: @exploration.id).all.to_a[0]
    Rails.logger.debug("Problems data: #{@problems.inspect}")
    # Create new variable for invitations form in ninth step
    @new = Exploration.new
    # if @step == "first"
    #  ExplorationUser.update(@exploration_user_id.id, :status => 'intro')
    if @step == "intro"
      ExplorationUser.update(@exploration_user.id, :status => 'first', :started => Time.now)
    elsif @step == "pthanks"
      ExplorationUser.update(@exploration_user.id, :status => 'ninth', :completed => Time.now)
    else
      ExplorationUser.update(@exploration_user.id, :status => @step)
    end

  end

end