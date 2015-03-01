class RemoveExplorerIdFromExploration < ActiveRecord::Migration
  def change
    remove_column :explorations, :explorer_id, :integer
  end
end
