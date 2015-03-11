class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    require 'date'
    @start = ExplorationUser.new
    @new = Exploration.new
    
    # Create array of all Exploration IDs
    exploration_ids = Exploration.all.map(& :id)
    Rails.logger.debug("All exploration IDs are: #{exploration_ids.inspect}")
    # Grab all Exploration User info about current user
    @exploration_users = current_user.exploration_users
    Rails.logger.debug("Current User Exploration User info: #{@exploration_users.inspect}")
    # Create array of all Exploration IDs where current user has chosen to explore
    @exploration_ids = @exploration_users.where(user_chosen: "yes").pluck(:exploration_id)
    Rails.logger.debug("Current User Exploration User IDs: #{@exploration_ids.inspect}")
    # Create array of all Exploration IDs where current user has not yet chosen to explore but has been invited to explore
    @friend_invitations_ids = @exploration_users.where(user_chosen: "no").pluck(:exploration_id)
    Rails.logger.debug("Friend invitations: #{@friend_invitations_ids.inspect}")
    # Create array of all Exploration IDs where current user is NOT connected in the Exploration User model
    @unexplored_exploration_ids = exploration_ids - @exploration_ids - @friend_invitations_ids
    Rails.logger.debug("Explorations User is not exploring: #{@unexplored_exploration_ids.inspect}")

    # If current user has chosen to explore any Explorations, loop through them to show them here 
    if !@exploration_ids.empty?
      # Get explorations that the current user is exploring
      @explorations = Exploration.where(id: @exploration_ids)
      Rails.logger.debug("Explorations User has chosen: #{@explorations.inspect}")
      @time = Time.now
    end   
    # If current user is exploring any Explorations, loop through them to show them here 
    if !@friend_invitations_ids.empty?
      # Get explorations that the current user is exploring
      @friend_invitations = Exploration.where(id: @friend_invitations_ids)
      Rails.logger.debug("Explorations User has not yet chosen: #{@friend_invitations.inspect}")
      @time = Time.now
    end   
    # If current user is NOT exploring any Explorations that are available, loop through them to show them here
    if !@unexplored_exploration_ids.empty?
      @time = Time.now
      @unexplored_explorations = Exploration.where(id: @unexplored_exploration_ids)
      Rails.logger.debug("Unexplored explorations: #{@unexplored_explorations.inspect}")      
    end   
  end
  
  def update
      # Determine if update is coming from Friend Invitations view or Unexplored View
      if params[:id] == "new"
        # Add exploration to User Activity view
        new_exploration_user = ExplorationUser.new(:exploration_id => params[:exploration_user][:exploration_id], 
        :user_id => current_user.id, :status => 0, :user_chosen => "yes")
         # Once added return to new Activity view
        if new_exploration_user.save
          redirect_to user_session_path and return
        end
      else
        # Update Exploration User instance rather than create a new one
        update_exploration_user = ExplorationUser.update(params[:exploration_user][:exploration_user_id], :user_chosen => "yes")
        if update_exploration_user.save
          redirect_to user_session_path and return
        end
      end
  end

  def invite
    User.invite!({:email => "new_user@example.com"}, current_user)
  end
end