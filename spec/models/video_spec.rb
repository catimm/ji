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

require 'rails_helper'

RSpec.describe Video, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
