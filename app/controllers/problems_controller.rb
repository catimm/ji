class ProblemsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    # Grab data from params
    @exploration_user_id = ExplorationUser.find(params[:exploration_user_id])
    @step = params[:id]
    Rails.logger.debug("Current step: #{@step.inspect}")
    # Create written input form for steps that use that
    @written = WrittenInput.new
    # Pass variables to problem.js.erb
    gon.current_user = current_user.id
    gon.exploration_id = @exploration_user_id.exploration_id
    gon.step = @step
    # Create problems variable for second step
    @problems = Problem.where(exploration_id: @exploration_user_id.exploration_id)
    # Create new variable for invitations form in ninth step
    @new = Exploration.new
    # if @step == "first"
    #  ExplorationUser.update(@exploration_user_id.id, :status => 'intro')
    if @step == "intro"
      ExplorationUser.update(@exploration_user_id.id, :status => 'first')
    elsif @step == "pthanks"
      ExplorationUser.update(@exploration_user_id.id, :status => 'ninth', :completed => Time.now)
    else
      ExplorationUser.update(@exploration_user_id.id, :status => @step)
    end

  end

end