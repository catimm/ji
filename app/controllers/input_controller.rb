class InputController < ApplicationController
  def first  
   
  end
  
  def first_input_response 
    respond_to do |format|               
      format.js 
    end 
  end
  
  def video_url
    data = JSON.parse(request.raw_post)
    video_uuid = data["uuid"]
  end
  
end