class InputController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def video_url
    information = request.raw_post
    data_parsed = JSON.parse(information)
    
    video = Video.new
    video.uuid = data_parsed['uuid']
    video.video_url = data_parsed['formats'][0]['video_url']
    video.user_id = data_parsed['metadata']['user']
    video.camera = data_parsed['metadata']['camera']
    video.save!
  end
  
  def view_video_info
    @video = Video.find(1)
  end
  
  def record
    
  end
end