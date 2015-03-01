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
#

class Exploration < ActiveRecord::Base

  has_many :explorers
  has_many :exploration_users
  has_many :users, through: :exploration_users
  has_many :problems
  
end
