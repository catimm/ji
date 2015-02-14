class ProblemController < ApplicationController

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
    ExplorationUser.update(session[:exploration_users_id], :status => '3')
  end
  
  def fifth
    ExplorationUser.update(session[:exploration_users_id], :status => '4')
  end
  
  def sixth
    ExplorationUser.update(session[:exploration_users_id], :status => '5')
  end
  
  def seventh
    @sessions_info = session[:exploration_users_id]
    ExplorationUser.update(session[:exploration_users_id], :status => '6')
  end
  
  def ninth
    time = Time.now
    ExplorationUser.update(session[:exploration_users_id], :status => '8', :completed => time)
  end
end