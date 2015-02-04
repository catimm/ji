class AddStepsToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :steps, :integer
  end
end
