class AddPictureLgToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :picture_lg, :string
  end
end
