class InvitationsController < Devise::InvitationsController
  
  def new
    session[:exploration_id] = params[:exploration][:invited_for_exploration_id]
    Rails.logger.debug("New Exploration ID is: #{session[:exploration_id].inspect}")
    super
  end
  
  def create
    description = Exploration.where(id: session[:exploration_id]).pluck(:short_description)
    short_description = description[0]
    @invited_user = User.invite!(invite_params, current_inviter) do |u|
      # Skip sending the default Devise Invitable e-mail
      u.skip_invitation = true
    end

    # Set the value for :invitation_sent_at because we skip calling the Devise Invitable method deliver_invitation which normally sets this value
    @invited_user.update_attribute :invitation_sent_at, Time.now.utc unless @invited_user.invitation_sent_at
    # Use our own mailer to send the invitation e-mail
    UserMailer.invite_email(@invited_user, current_user, short_description).deliver
    
    invited_user_email = params[:user][:email]
    invited_user_id = User.where(email: invited_user_email).pluck(:id)
    User.update(invited_user_id[0], invited_for_exploration_id: session[:exploration_id]) 

    redirect_to user_session_path
  end
  
  def update
    super
    raw_token = params[:user][:invitation_token]
    invitation_token = Devise.token_generator.digest(User, :invitation_token, raw_token)
    user_id = User.where(invitation_token: invitation_token).pluck(:id)
    exploration_id = User.where(id: user_id).pluck(:invited_for_exploration_id)

    new_exploration_user = ExplorationUser.new(:exploration_id => exploration_id[0], :user_id => user_id[0], :status => 0)
    new_exploration_user.save!
  
      
  end
end