class AddCameraToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :camera, :string
  end
end
