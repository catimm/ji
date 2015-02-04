# == Schema Information
#
# Table name: problems
#
#  id             :integer          not null, primary key
#  exploration_id :integer
#  title          :string(255)
#  description    :text
#  problem_one    :text
#  problem_two    :text
#  problem_three  :text
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe Problem, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
