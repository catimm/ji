# == Schema Information
#
# Table name: exploration_invitations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  friend_email   :string(255)
#  accept         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  exploration_id :integer
#

class ExplorationInvitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :exploration
    
end
