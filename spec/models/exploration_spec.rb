# == Schema Information
#
# Table name: explorations
#
#  id                      :integer          not null, primary key
#  exploration_category    :string(255)
#  completions_required    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  steps                   :integer
#  end_date                :datetime
#  title                   :string(255)
#  description             :text
#  short_description       :string(255)
#  picture_xs              :string(255)
#  picture_sm              :string(255)
#  picture_lg              :string(255)
#  exploration_users_count :integer
#  exploration_phase       :string(255)
#  survey_access_code      :string(255)
#  start_date              :datetime
#

require 'rails_helper'

RSpec.describe Exploration, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
