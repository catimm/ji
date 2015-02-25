class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    require 'date'
    @start = ExplorationUser.new
    @new = Exploration.new
    
    
    Rails.logger.debug("Exploration & users info: #{@explorations_test.inspect}")
    # Use the below to reset the counters in Exploration
    # Exploration.find_each { |exploration| Exploration.reset_counters(exploration.id, :exploration_users) }
    
    
    
    # Create array of all Exploration IDs
    exploration_ids = Exploration.all.map(& :id)
    Rails.logger.debug("All exploration IDs are: #{exploration_ids.inspect}")
    # Create array of all Exploration IDs where current user is exploring
    @exploration_ids = current_user.exploration_ids
    Rails.logger.debug("IDs of User explorations: #{@exploration_ids.inspect}")
    # Create array of all Exploration IDs where current user is NOT exploring
    @unexplored_exploration_ids = exploration_ids - @exploration_ids
    Rails.logger.debug("Explorations User is not exploring: #{@unexplored_exploration_ids.inspect}")

    # If current user is NOT exploring any Explorations that are available, loop through them to show them here
    if !@unexplored_exploration_ids.empty?
      @unexplored_explorations = Exploration.where(id: @unexplored_exploration_ids)
    
      @unexplored_explorations.each do |b|
        @time = Time.now
      end
    end
    
    # If current user is exploring any Explorations, loop through them to show them here 
    if !@exploration_ids.empty?
      # Get explorations that the current user is exploring
      @explorations = current_user.explorations
      Rails.logger.debug("Explorations User is active: #{@explorations.inspect}")
   
      # Loop through each exploration to create an overview View
      @explorations.each do |d|
        @time = Time.now
        user_status = d.exploration_users.where(user_id: current_user).pluck(:status)[0]
      
        if user_status >= 1
          gon.status = user_status
          respond_to do |format|               
            format.html
          end
        end
      end
    end      
  end
  
  def update
    if params[:commit] == "I'll share!"
      new_exploration_user = ExplorationUser.new(:exploration_id => params[:exploration_user][:exploration_id], :user_id => current_user.id, :status => 0)
    
      if new_exploration_user.save
        redirect_to user_session_path
      end
    else
      exploration_user = ExplorationUser.where(id: params[:exploration_user][:id]).all.to_a
      
      session[:exploration_users_id] = params[:exploration_user][:id]
      session[:exploration_id] = exploration_user.first.exploration_id
      
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