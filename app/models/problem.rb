# == Schema Information
#
# Table name: problems
#
#  id             :integer          not null, primary key
#  exploration_id :integer
#  problem_one    :text
#  problem_two    :text
#  problem_three  :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Problem < ActiveRecord::Base
  belongs_to :exploration
end
