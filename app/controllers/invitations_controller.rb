class InvitationsController < Devise::InvitationsController
  
  def new
    session[:exploration_id] = params[:exploration][:invited_for_exploration_id]
    Rails.logger.debug("New Exploration ID is: #{session[:exploration_id].inspect}")
    super
  end
  
  def create
    super
    invited_user_email = params[:user][:email]
    invited_user_id = User.where(email: invited_user_email).pluck(:id)
    User.update(invited_user_id[0], invited_for_exploration_id: session[:exploration_id]) 

  end
  
  def update
    
    raw_token = params[:user][:invitation_token]
    invitation_token = Devise.token_generator.digest(User, :invitation_token, raw_token)
    user_id = User.where(invitation_token: invitation_token).pluck(:id)
    exploration_id = User.where(id: user_id).pluck(:invited_for_exploration_id)

    new_exploration_user = ExplorationUser.new(:exploration_id => exploration_id[0], :user_id => user_id[0], :status => 0)
    
    if new_exploration_user.save
      super
    end
    
  end
end