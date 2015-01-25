# == Schema Information
#
# Table name: surveys
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  description            :text
#  access_code            :string(255)
#  reference_identifier   :string(255)
#  data_export_identifier :string(255)
#  common_namespace       :string(255)
#  common_identifier      :string(255)
#  active_at              :datetime
#  inactive_at            :datetime
#  css_url                :string(255)
#  custom_class           :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  display_order          :integer
#  api_id                 :string(255)
#  survey_version         :integer          default(0)
#  template               :boolean          default(FALSE)
#  user_id                :integer
#

class Survey < ActiveRecord::Base
      include Surveyor::Models::SurveyMethods
      def title
        "Custom #{super}"
      end
    end
