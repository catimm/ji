class UsersController < ApplicationController
  def show
    require 'date'
    @problems = Problem.find_by id: '1'
    
    asking = @problems.exploration.completions_required
    completed = ExplorationUser.where("completed IS NOT NULL").count
    finished = @problems.exploration.end_date

    @time = Time.now
    
    @people = completed
    @completed = (completed / asking).round
    @days_left = ((finished - @time)/1.day).round  
    
    Rails.logger.debug("My finished #: #{finished.inspect}")

    @start = ExplorationUser.new
    
  end
  
  def update
    
  end
end