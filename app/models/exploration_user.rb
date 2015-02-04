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

class ExplorationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :exploration
  
end
