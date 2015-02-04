class InputController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def action
    @current_user = current_user
    gon.current_user = @current_user
  
  end
  
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
    video.uuid = data_parsed['uuid']
    video.video_url = data_parsed['formats'][0]['video_url']
    video.user_id = data_parsed['metadata']['user']
    video.camera = data_parsed['metadata']['camera']
  end
  
  def view_video_info
    @video = Video.find(1)
  end
end