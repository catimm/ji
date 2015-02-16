class ProblemController < ApplicationController
  before_filter :authenticate_user!
  
  def first
    
  end
  
  def second
    
    ExplorationUser.update(session[:exploration_users_id], :status => '1')
    @sessions_info = session[:exploration_users_id]
    @problems = Problem.where(id: '1')
    Rails.logger.debug("Problem info is: #{@problems.inspect}")
    
    gon.current_user = current_user.id
    Rails.logger.debug("Gon current user is: #{gon.current_user.inspect}")
    
  end
  
  def fourth
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
    end
    ExplorationUser.update(session[:exploration_users_id], :status => '3')
  end
  
  def fifth
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
    end
    ExplorationUser.update(session[:exploration_users_id], :status => '4')
  end
  
  def sixth
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
    end
    ExplorationUser.update(session[:exploration_users_id], :status => '5')
  end
  
  def seventh
    @sessions_info = session[:exploration_users_id]
    ExplorationUser.update(session[:exploration_users_id], :status => '6')
  end
  
  def ninth
    time = Time.now
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
    end
    
    ExplorationUser.update(session[:exploration_users_id], :status => '8', :completed => time)
    exploration_id = ExplorationUser.where(id: session[:exploration_users_id]).pluck(:exploration_id)
    @sessions_info = exploration_id[0]
    @new = Exploration.new
    
  end
end