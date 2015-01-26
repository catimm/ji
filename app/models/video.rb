# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  uuid       :string(255)
#  completed  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  video_url  :string(255)
#

class Video < ActiveRecord::Base
end
