class AddPictureXsToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :picture_xs, :string
  end
end
