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
    video.exploration_id = data_parsed['metadata']['exploration_id']
    video.save!
  end
  
  def record 
  end
end