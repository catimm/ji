class RemoveCameraColumnsFromProblem < ActiveRecord::Migration
  def change
    remove_column :problems, :camera_two_id, :string
    remove_column :problems, :camera_four_id, :string
    remove_column :problems, :camera_five_id, :string
    remove_column :problems, :camera_six_id, :string
    remove_column :problems, :camera_seven_id, :string
  end
end
