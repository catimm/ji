# == Schema Information
#
# Table name: exploration_users
#
#  id             :integer          not null, primary key
#  exploration_id :integer
#  user_id        :integer
#  started        :datetime
#  completed      :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  status         :integer
#

require 'rails_helper'

RSpec.describe ExplorationUser, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
