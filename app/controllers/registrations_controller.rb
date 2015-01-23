class RegistrationsController < Devise::RegistrationsController
    
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end
  
  def build_resources(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end 
  end

  def after_sign_up_path_for(resource)
    @user = confirm_path
  end
  
  def after_inactive_sign_up_path_for(resource) 
    @user = confirm_path
  end

end