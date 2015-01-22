class HomeController < ApplicationController
  
  def index  
    # Ziggeo credentials
    ziggeo = Ziggeo.new("a43572f97516b35e30e36c1ccff7a9fc", "a69ee2ed945bcc6273a7d09edc59ef92", "0c92b79b4097640d4ead73efaa5bdd23")
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