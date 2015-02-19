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
    @written = WrittenInput.new
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
    end
    ExplorationUser.update(session[:exploration_users_id], :status => '3')
  end
  
  def fifth
    # Make sure the exploration_user_id and the exploration_id is available
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
      if session[:exploration_id].nil?
        exploration_user_info = ExplorationUser.where(id: session[:exploration_users_id]).pluck(:exploration_id)
        session[:exploration_id] = exploration_user_info[0]
      end
    end
    # Check if params exist--in case where coming from Show view, there won't be params . . .
    if params.has_key?(:written_input)
      # Insert written input if any exists
      input = params[:written_input][:written_input]
      if !input.empty?
        new_input = WrittenInput.new(:user_id => current_user.id, :exploration_id => session[:exploration_id], :written_input => input, :step => params[:written_input][:step])
        new_input.save!
      end
    end
     
    ExplorationUser.update(session[:exploration_users_id], :status => '4')
    @written = WrittenInput.new
  end
  
  def sixth
    # Make sure the exploration_user_id and the exploration_id is available
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
      if session[:exploration_id].nil?
        exploration_user_info = ExplorationUser.where(id: session[:exploration_users_id]).pluck(:exploration_id)
        session[:exploration_id] = exploration_user_info[0]
      end
    end
    # Check if params exist--in case where coming from Show view, there won't be params . . .
    if params.has_key?(:written_input)
      # Insert written input if any exists
      input = params[:written_input][:written_input]
      if !input.empty?
        new_input = WrittenInput.new(:user_id => current_user.id, :exploration_id => session[:exploration_id], :written_input => input, :step => params[:written_input][:step])
        new_input.save!
      end
    end

    ExplorationUser.update(session[:exploration_users_id], :status => '5')
    @written = WrittenInput.new
  end
  
  def seventh
    # Make sure the exploration_user_id and the exploration_id is available
    if session[:exploration_users_id].nil?
      session[:exploration_users_id] = params[:exploration_user][:id]
      if session[:exploration_id].nil?
        exploration_user_info = ExplorationUser.where(id: session[:exploration_users_id]).pluck(:exploration_id)
        session[:exploration_id] = exploration_user_info[0]
      end
    end
    # Check if params exist--in case where coming from Show view, there won't be params . . .
    if params.has_key?(:written_input)
      # Insert written input if any exists
      input = params[:written_input][:written_input]
      if !input.empty?
        new_input = WrittenInput.new(:user_id => current_user.id, :exploration_id => session[:exploration_id], :written_input => input, :step => params[:written_input][:step])
        new_input.save!
      end
    end
    
    @sessions_info = session[:exploration_users_id]
    ExplorationUser.update(session[:exploration_users_id], :status => '6')
    @written = WrittenInput.new
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