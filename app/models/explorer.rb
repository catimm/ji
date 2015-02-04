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

class Explorer < ActiveRecord::Base
  belongs_to :user
  
  has_many :explorations
  
  def self.full_name
    User.first_name+" "+self.last_name
  end
end
