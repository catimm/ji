class AddShortDescriptionToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :short_description, :string
  end
end
