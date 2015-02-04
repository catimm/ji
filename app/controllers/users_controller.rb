class UsersController < ApplicationController
  def show
    
    @explorations = Exploration.find_by id: '1'
    
    @explorer_id = @explorations.explorer_id
    @explorer = Explorer.find_by id: @explorer_id
    @explorer_last = @explorer.last_name
    @explorer_user = @explorer.user_id
    @explorer_name = User.find_by id: @explorer_user
    @explorer_first = @explorer_name.first_name
    
    asking = @explorations.completions_required
    completed = ExplorationUser.where("completed IS NOT NULL").count

    Rails.logger.debug("My asking #: #{asking.inspect}")
    Rails.logger.debug("My completed #: #{completed.inspect}")
    
    @people = asking - completed
    @completed = completed / asking

    @time = Time.now

    @start = ExplorationUser.new
    
  end
end