class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    require 'date'
    @start = ExplorationUser.new
    @exploration_user = ExplorationUser.where(user_id: current_user)
    Rails.logger.debug("Explorat User is: #{@exploration_user.inspect}")
    if @exploration_user.nil?
      redirect_to nothing_path
    else
      @exploration_user.each do |d|
        user_status = d.status
        gon.status = user_status
        Rails.logger.debug("User Status is: #{user_status.inspect}")
        @explorations = Exploration.where(id: d.exploration_id).all.to_a

        @explorations.each do |g|
          @time = Time.now
          asking = g.completions_required.to_f
          @completed = ((g.exploration_users.count(:completed) / asking)*100).round
          @people = g.exploration_users.count(:started) 
          @days_left = ((g.end_date - @time)/1.day).round
        end
      
        if user_status > 0
          respond_to do |format|               
            format.html
          end
        end
      end
    end   
    
  end
  
  def update
    exploration_user = ExplorationUser.where(id: params[:id]).all.to_a
    Rails.logger.debug("Exploration_user is: #{exploration_user.inspect}")
    
    session[:exploration_users_id] = params[:id]
    cookies[:exploration_users_id] = params[:id]
    Rails.logger.debug("ExUsID is: #{session[:exploration_users_id].inspect}")
    Rails.logger.debug("CookID is: #{cookies[:exploration_users_id].inspect}")
    status = exploration_user.first.status
    gon.status = status
    Rails.logger.debug("Status is: #{status.inspect}")
    if status == 0
      time = Time.now
      ExplorationUser.update(params[:id], :started => time)
      redirect_to step1_path
    else 
      redirect_to step1_path
    end
  end
end