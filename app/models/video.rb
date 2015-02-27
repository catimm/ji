# == Schema Information
#
# Table name: videos
#
#  id             :integer          not null, primary key
#  uuid           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  video_url      :string(255)
#  user_id        :integer
#  camera         :string(255)
#  exploration_id :integer
#  step           :string(255)
#

class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :exploration
end
