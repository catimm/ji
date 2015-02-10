class AddTitleAndDescriptionToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :title, :string
    add_column :explorations, :description, :text
  end
end
