class ProblemsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    # Grab data from params
    @exploration_user_id = ExplorationUser.find(params[:exploration_user_id])
    Rails.logger.debug("Exploration user info: #{@exploration_user_id.inspect}")
    @step = params[:id]
    # Grab exploration data for view variables
    @exploration = Exploration.find(@exploration_user_id.exploration_id)
    
    # Create written input form for steps that use that
    @written = WrittenInput.new
    # Pass variables to problem.js.erb
    gon.current_user = current_user.id
    gon.exploration_id = @exploration_user_id.exploration_id
    gon.step = @step
    # Create problems variable for dynamic input in various steps
    @problems = Problem.where(exploration_id: @exploration_user_id.exploration_id).all.to_a[0]
    Rails.logger.debug("Problems data: #{@problems.inspect}")
    # Create new variable for invitations form in ninth step
    @new = Exploration.new
    # if @step == "first"
    #  ExplorationUser.update(@exploration_user_id.id, :status => 'intro')
    if @step == "intro"
      ExplorationUser.update(@exploration_user_id.id, :status => 'first', :started => Time.now)
    elsif @step == "pthanks"
      ExplorationUser.update(@exploration_user_id.id, :status => 'ninth', :completed => Time.now)
    else
      ExplorationUser.update(@exploration_user_id.id, :status => @step)
    end

  end

end