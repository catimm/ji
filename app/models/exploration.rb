# == Schema Information
#
# Table name: explorations
#
#  id                   :integer          not null, primary key
#  category             :string(255)
#  picture              :string(255)
#  completions_required :integer
#  created_at           :datetime
#  updated_at           :datetime
#  explorer_id          :integer
#  steps                :integer
#  end_date             :datetime
#  title                :string(255)
#  description          :text
#

class Exploration < ActiveRecord::Base
  belongs_to :explorer
  
  has_many :exploration_users
  has_many :exploration_invitations
  has_many :problems
  
  def self.feedback_complete(id)
    ExplorationUser.where(:exploration_id => id).where("completed IS NOT NULL").count
  end
  
  def self.feedback_completed
    ExplorationUser.where(:exploration_id => self.id).where("completed IS NOT NULL").count
  end
end
