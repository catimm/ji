class RemovePictureFromExploration < ActiveRecord::Migration
  def change
    remove_column :explorations, :picture, :string
  end
end
