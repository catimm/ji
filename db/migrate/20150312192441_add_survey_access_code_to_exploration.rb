class AddSurveyAccessCodeToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :survey_access_code, :string
  end
end
