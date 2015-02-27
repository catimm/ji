class AddCameraTwoIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :camera_two_id, :string
  end
end
