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
#

class Exploration < ActiveRecord::Base
  belongs_to :explorer
  
  has_many :exploration_users
  has_many :exploration_invitations
  has_many :problems
end
