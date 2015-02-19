# == Schema Information
#
# Table name: written_inputs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  exploration_id :integer
#  written_input  :text
#  step           :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class WrittenInput < ActiveRecord::Base
  belongs_to :user
  belongs_to :exploration
end
