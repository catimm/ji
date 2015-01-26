# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  uuid       :string(255)
#  url        :string(255)
#  completed  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Video, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
