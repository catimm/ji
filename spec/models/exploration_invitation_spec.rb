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

require 'rails_helper'

RSpec.describe ExplorationInvitation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
