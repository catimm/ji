class AuthenticationsController < ApplicationController

  def home
  end
  
  def linkedin
    omni = request.env["omniauth.auth"]
    Rails.logger.debug("My omni object: #{omni.inspect}")
    registered = User.find_by_email(omni['info']['email'])
    omni2 = omni['extra']['raw_info']
     Rails.logger.debug("My omni2 object: #{omni2.inspect}")

    if registered # this section simply logs in a user who has authenticated with LI before
      sign_in_and_redirect User.find(registered.id)
      
    else # this section is for a user who has not yet registered for Partake and is using LI to do so
      user = User.new
      user.first_name = omni['info']['first_name']
      user.last_name = omni['info']['last_name']
      user.email = omni['info']['email']
      user.apply_omniauth(omni)
      
      if user.save
        flash[:notice] = "Logged in."
        sign_in_and_redirect User.find(user.id)
      else
        session[:omniauth] = omni.except('extra')
        flash[:notice] = "Something went awry. Please try again."
        redirect_to new_user_registration_path
      end
    end
  end
end
