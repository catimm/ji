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

require 'rails_helper'

RSpec.describe WrittenInput, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
