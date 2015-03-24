class InvitationsController < Devise::InvitationsController
  
  def new
    if params.has_key?(:exploration)
      @exploration_id = params[:exploration][:invited_for_exploration_id]
    else
      @exploration_id = params[:format]
    end
    # Get projection description
    exploration_info = Exploration.find(@exploration_id)
    @project_description = exploration_info.short_description
    # Find out if current user is project owner
    @project_owners = Explorer.where(exploration_id: @exploration_id).pluck(:user_id)
    Rails.logger.debug("Project owners: #{@project_owners.inspect}")
    # If current user is project owner, set variable to "yes"
    if @project_owners.include? current_user.id
      @owner = "yes"
    else
      @owner = "no"
    end
    Rails.logger.debug("Current user is project owner: #{@owner.inspect}")
    # Set session id to equal exploration id
    session[:exploration_id] = @exploration_id
    # Run original devise invitable code
    super
  end
  
  def create
    # Get project description
    description = Exploration.where(id: params[:user][:invited_for_exploration_id]).pluck(:short_description)[0]
    # Get time to provide input
    time = Problem.where(exploration_id: params[:user][:invited_for_exploration_id]).pluck(:time_to_take)[0]
    # Find out relationship of current user to project owner
    project_relationship = params[:user][:email_option]
    # Make sure project relationship is not empty. If it is empty, send user back to page with an error.
    if project_relationship.empty?
      flash[:failure] = "Please choose an option from the drop down"
      redirect_to exploration_problem_path(params[:user][:invited_for_exploration_id], params[:user][:problem_id]) and return
    end
    # add invited person to User model
    @invited_user = User.invite!(invite_params, current_inviter) do |u|
      # Skip sending the default Devise Invitable e-mail
      u.skip_invitation = true
    end
    # Set the value for :invitation_sent_at because we skip calling the Devise Invitable method deliver_invitation which normally sets this value
    @invited_user.update_attribute :invitation_sent_at, Time.now.utc unless @invited_user.invitation_sent_at
    # Set reminders to "0" for all invited users
    @invited_user.update_attribute :reminders, 0
    # Grab User model info of new invitee
    invited_user = User.where(email: params[:user][:email]).all.to_a[0]
    Rails.logger.debug("Invited User: #{invited_user.inspect}")
    # Add Exploration User model instance for new invitee if they aren't already in Exploration User model for this Exploration
    exploration_user_check = ExplorationUser.where(user_id: invited_user.id, exploration_id: params[:user][:invited_for_exploration_id])
    Rails.logger.debug("Exploration User Check: #{exploration_user_check.inspect}")
    if exploration_user_check.empty?
      new_exploration_user = ExplorationUser.new(:exploration_id => params[:user][:invited_for_exploration_id], 
      :user_id => invited_user.id, :status => 0, :invited_by_user_id => current_user.id, :user_chosen => "no")
      new_exploration_user.save! 
    end
    # Send appropriate callback link to invitee--to either login or set password, based on whether invitee is already in User model
    if invited_user.encrypted_password.empty?
      link = root_url+"users/invitation/accept?invitation_token="+@invited_user.raw_invitation_token
    else
      link = root_url+"/users/login"
    end
    # send different mail based on project_relationship value
    if project_relationship == "owner"
      # Send invitation e-mail using version sent from project owner
      UserMailer.signup_reminder_email(@invited_user.first_name, @invited_user.email, current_user, description, link).deliver
      # FirstReminderWorker.perform_at(2.minutes.from_now, @invited_user.id, current_user.first_name, description, link)
      # SecondReminderWorker.perform_at(7.days.from_now, @invited_user.id, current_user.first_name, description, link)
    elsif project_relationship == "friend"
      # Send invitation e-mail using version sent from friend of project owner
      UserMailer.friend_invite_email(@invited_user, current_user, description, time, link).deliver
      # FirstReminderWorker.perform_at(3.days.from_now, @invited_user, current_user.first_name, description, link)
      # SecondReminderWorker.perform_at(7.days.from_now, @invited_user, current_user.first_name, description, link)
    elsif project_relationship == "friend-of-friend"
      # Send invitation e-mail using version sent from friend-of-a-friend of project owner
      UserMailer.fof_invite_email(@invited_user, current_user, description, time, link).deliver
      # FirstReminderWorker.perform_at(3.days.from_now, @invited_user, current_user.first_name, description, link)
      # SecondReminderWorker.perform_at(7.days.from_now, @invited_user, current_user.first_name, description, link)
    else
      # Send invitation e-mail using version non-connected, interested person
      UserMailer.general_invite_email(@invited_user, current_user, description, time, link).deliver
      # FirstReminderWorker.perform_at(3.days.from_now, @invited_user, current_user.first_name, description, link)
      # SecondReminderWorker.perform_at(7.days.from_now, @invited_user, current_user.first_name, description, link)
    end  
    
    # Redirect current user back to Invitation view and send the exploration id through to be referenced again
    flash[:success] = "You've successfully sent the invite!"
    redirect_to exploration_problem_path(params[:user][:invited_for_exploration_id],params[:user][:problem_id])
    
  end
  
  def update
    super
  end
end