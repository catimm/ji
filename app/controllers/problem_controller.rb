class ProblemController < ApplicationController

  def first
  end
  
  def second
    @problems = Problem.where(id: '1')
    Rails.logger.debug("Problem info is: #{@problems.inspect}")
    
    gon.current_user = current_user.id
    Rails.logger.debug("Gon current user is: #{gon.current_user.inspect}")
  end
  
  def fourth
  end
  
  def fifth
  end
  
  def sixth
  end
  
  def seventh
  end
  
  def ninth
  end
end