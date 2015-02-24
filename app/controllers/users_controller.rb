class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    require 'date'
    @start = ExplorationUser.new
    @new = Exploration.new
    
    # Create array of all Exploration IDs
    exploration_ids = Exploration.all.map(& :id)
    Rails.logger.debug("All exploration IDs are: #{exploration_ids.inspect}")
    # Create array of all Exploration IDs where current user is exploring
    @exploration_user_ids = ExplorationUser.where(user_id: current_user).pluck(:exploration_id)
    Rails.logger.debug("Explorations User is exploring: #{@exploration_user_ids.inspect}")
    # Create array of all Exploration IDs where current user is NOT exploring
    @unexplored_exploration_ids = exploration_ids - @exploration_user_ids
    Rails.logger.debug("Explorations User is not exploring: #{@unexplored_exploration_ids.inspect}")

    # If current user is NOT exploring any Explorations that are available, loop through them to show them here
    if !@unexplored_exploration_ids.empty?
      Rails.logger.debug("Unexplored Explorations IDs are: #{@unexplored_exploration_ids.inspect}")
      @unexplored_explorations = Exploration.where(id: @unexplored_exploration_ids)
      Rails.logger.debug("Unexplored Explorations are: #{@unexplored_explorations.inspect}")
    
      @unexplored_explorations.each do |b|
        @time = Time.now
        asking = b.completions_required.to_f
        @completed = b.exploration_users.count(:completed)
        @people = b.exploration_users.count(:started) 
        @days_left = ((b.end_date - @time)/1.day).round
      end
    end
    
    # If current user is exploring any Explorations, loop through them to show them here 
    if !@exploration_user_ids.empty?
      @exploration_user = ExplorationUser.where(user_id: current_user)
      Rails.logger.debug("Explorat User is: #{@exploration_user.inspect}")

      @exploration_user.each do |d|
        user_status = d.status
        gon.status = user_status
        Rails.logger.debug("User Status is: #{user_status.inspect}")
        @explorations = Exploration.where(id: d.exploration_id).all.to_a

        @explorations.each do |g|
          @time = Time.now
          asking = g.completions_required.to_f
          @completed = g.exploration_users.count(:completed)
          @people = g.exploration_users.count(:started) 
          @days_left = ((g.end_date - @time)/1.day).round
        end
      
        if user_status >= 1
          respond_to do |format|               
            format.html
          end
        end
      end
    end      
  end
  
  def update
    if params[:commit] == "I'm interested!"
      new_exploration_user = ExplorationUser.new(:exploration_id => params[:exploration_user][:exploration_id], :user_id => current_user.id, :status => 0)
    
      if new_exploration_user.save
        redirect_to user_session_path
      end
    else
      exploration_user = ExplorationUser.where(id: params[:exploration_user][:id]).all.to_a
      Rails.logger.debug("Exploration_user is: #{exploration_user.inspect}")
      
      session[:exploration_users_id] = params[:exploration_user][:id]
      session[:exploration_id] = exploration_user.first.exploration_id
      cookies[:exploration_users_id] = params[:exploration_user][:id]
      Rails.logger.debug("ExUsID is: #{session[:exploration_users_id].inspect}")
      Rails.logger.debug("CookID is: #{cookies[:exploration_users_id].inspect}")
      status = exploration_user.first.status
      gon.status = status
      Rails.logger.debug("Status is: #{status.inspect}")
      if status == 0
        time = Time.now
        ExplorationUser.update(params[:exploration_user][:id], :started => time)
        redirect_to step1_path
      else 
        redirect_to step1_path
      end
    end
    
  end

  def invite
    User.invite!({:email => "new_user@example.com"}, current_user)
  end
end