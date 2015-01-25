class AuthenticationsController < ApplicationController

  def home
  end
  
  def linkedin
    omni = request.env["omniauth.auth"]
    Rails.logger.debug("My omni object: #{omni.inspect}")
    registered = User.find_by_email(omni['info']['email'])
    omni2 = omni['extra']['raw_info']
     Rails.logger.debug("My omni2 object: #{omni2.inspect}")

    if registered # this section logs in a user who has authenticated with LI before or will first add their LI info to the authentications table before logging in
      authenticated = Authentication.find_by_user_id(registered.id)
      if authenticated
        sign_in_and_redirect User.find(registered.id)
      else
        authenticating = Authentication.new
        authenticating.user_id = registered.id
        authenticating.provider = omni['provider']
        authenticating.uid = omni['uid']
        authenticating.token = omni['credentials']['token']
        authenticating.token_secret = omni['credentials']['secret']

        if authenticating.save
          sign_in_and_redirect User.find(registered.id)
        else
          session[:omniauth] = omni.except('extra')
          redirect_to new_user_registration_path
        end
     
      end
      
      
    else # this section is for a user who has not yet registered for ji and is using LI to do so
      user = User.new
      user.first_name = omni['info']['first_name']
      user.email = omni['info']['email']
      user.apply_omniauth(omni)
      
      if user.save
        sign_in_and_redirect User.find(user.id)
      else
        session[:omniauth] = omni.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end
end
