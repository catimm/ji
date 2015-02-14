class SessionsController < Devise::SessionsController
  def create  
    
    respond_to do |format|  
      format.html { super }  
      format.json {  
        warden.authenticate!(:scope => resource_name, :recall => "sessions#failure")  
        render :status => 200,
               :json =>
               {
                 :success => true,
                 :token => current_user.authentication_token,
                 :email => current_user.email,
                 :first_name => current_user.first_name,
                 :last_name => current_user.last_name
               }
      }  
    end  
  end

  def failure
    redirect_to new_user_registration_path, :json => {:success => false, :errors => ["Login failed. Please sign up!"] }
  end
end