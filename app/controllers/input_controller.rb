class InputController < ApplicationController
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
    @video_uuid = data_parsed["uuid"]
  end
  
end