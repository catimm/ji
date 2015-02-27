class AddCameraFourIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :camera_four_id, :string
  end
end
