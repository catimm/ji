# == Schema Information
#
# Table name: explorers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  last_name  :string(255)
#  city       :string(255)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Explorer, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
