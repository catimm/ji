# == Schema Information
#
# Table name: explorers
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  last_name      :string(255)
#  city           :string(255)
#  state          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  exploration_id :integer
#  lead_explorer  :string(255)
#

class Explorer < ActiveRecord::Base
  belongs_to :user
  belongs_to :exploration
  
end
