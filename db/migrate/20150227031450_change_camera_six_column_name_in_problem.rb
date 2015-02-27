class ChangeCameraSixColumnNameInProblem < ActiveRecord::Migration
  def change
    rename_column :problems, :camera_six, :camera_six_id
  end
end
