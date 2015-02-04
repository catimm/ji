class RemoveTitleAndDescriptionFromExploration < ActiveRecord::Migration
  def change
    remove_column :explorations, :title, :string
    remove_column :explorations, :description, :text
  end
end
