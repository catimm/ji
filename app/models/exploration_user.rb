# == Schema Information
#
# Table name: exploration_users
#
#  id                 :integer          not null, primary key
#  exploration_id     :integer
#  user_id            :integer
#  started            :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  status             :string(255)
#  completed          :datetime
#  invited_by_user_id :integer
#  user_chosen        :string(255)
#

class ExplorationUser < ActiveRecord::Base
  include DeviseInvitable::Inviter
  
  belongs_to :user
  belongs_to :exploration, counter_cache: true
  
end
