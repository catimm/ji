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
#  status         :integer
#  completed      :datetime
#

class ExplorationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :exploration, counter_cache: true
  
end
