class HomeController < ApplicationController
  
  def index  

  end
  
  def video_choice 
    respond_to do |format|               
      format.js 
    end 
  end
  
  def audio_choice 
    respond_to do |format|               
      format.js
    end 
  end
  
  def text_choice 
    respond_to do |format|               
      format.js
    end 
  end

end