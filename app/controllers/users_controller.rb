class UsersController < ApplicationController
  def show
    require 'date'
    
    @exploration_user = ExplorationUser.where(user_id: current_user)

    if @exploration_user.nil?
      redirect_to nothing_path
    else
      @exploration_user.each do |d|
        @explorations = Exploration.where(id: d.exploration_id).all.to_a
        Rails.logger.debug("Explorations are: #{@explorations.inspect}")
        @explorations.each do |g|
          @time = Time.now
          asking = g.completions_required.to_f
          @completed = ((g.exploration_users.count(:completed) / asking)*100).round
          @people = g.exploration_users.count(:started) 
          @days_left = ((g.end_date - @time)/1.day).round

          Rails.logger.debug("asking is: #{asking.inspect}")
          Rails.logger.debug("completed is: #{@completed.inspect}")
          Rails.logger.debug("people is: #{@people.inspect}")
          Rails.logger.debug("finished is: #{@days_left.inspect}")
  
          end
        end
    end   

    @start = ExplorationUser.new
    
  end
  
  def update
    exploration_user = ExplorationUser.where(id: params[:id]).all.to_a
    Rails.logger.debug("Exploration_user is: #{exploration_user.inspect}")
    status = exploration_user.first.status
    Rails.logger.debug("Status is: #{status.inspect}")
    if status == 0
      time = Time.now
      ExplorationUser.update(params[:id], :status => '1', :started => time)
      redirect_to step1_path
    elsif status == 1
      ExplorationUser.update(params[:id], :status => '2')
    elsif status == 2
      ExplorationUser.update(params[:id], :status => '3')
    elsif status == 3
      ExplorationUser.update(params[:id], :status => '4')
    elsif status == 4
      ExplorationUser.update(params[:id], :status => '5')
    elsif status == 5
      ExplorationUser.update(params[:id], :status => '6')
    elsif status == 6
      ExplorationUser.update(params[:id], :status => '7')
    elsif status == 7        
      ExplorationUser.update(params[:id], :status => '8')
    else  
      render :file => "public/404", :status => 404
    end

  end
end