class RemoveTitleAndDescriptionFromProblem < ActiveRecord::Migration
  def change
    remove_column :problems, :title, :string
    remove_column :problems, :description, :text
  end
end
