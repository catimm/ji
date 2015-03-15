class AddProjectBackgroundToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :project_background, :text
  end
end
