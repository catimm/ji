class AddPictureSmToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :picture_sm, :string
  end
end
