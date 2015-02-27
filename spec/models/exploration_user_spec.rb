# == Schema Information
#
# Table name: exploration_users
#
#  id             :integer          not null, primary key
#  exploration_id :integer
#  user_id        :integer
#  started        :datetime
#  created_at     :datetime
#  updated_at     :datetime
#  status         :string(255)
#  completed      :datetime
#

require 'rails_helper'

RSpec.describe ExplorationUser, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
