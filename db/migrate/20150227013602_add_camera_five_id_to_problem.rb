class AddCameraFiveIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :camera_five_id, :string
  end
end
