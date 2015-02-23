class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:invite) << :first_name
    devise_parameter_sanitizer.for(:invite) << :invited_for_exploration_id
    devise_parameter_sanitizer.for(:accept_invitation) << :first_name
    devise_parameter_sanitizer.for(:accept_invitation) << :invited_for_exploration_id
  end

  
  private
  
  def authenticate_user_from_token!
    email = params[:email].presence
    user = email && User.find_by_email(email)
  
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:token])
      sign_in user, store: false
    else
      render :status => 401, :json => {:success => false, :errors => ["Unauthorized access"] }
    end
  end

  
  def after_sign_in_path_for(resource)
    @user = current_user
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
end
