class AddCameraSevenIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :camera_seven_id, :string
  end
end
