class InputController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def first  
   
  end
  
  def first_input_response 
    respond_to do |format|               
      format.js 
    end 
  end
  
  def video_url
    information = request.raw_post
    data_parsed = JSON.parse(information)
    
    video = Video.new
    video.uuid = data_parsed["uuid"]
    video.completed = data_parsed['formats']["state"]

  end
  
  def view_video_info
    @video = Video.find(1)
  end
end