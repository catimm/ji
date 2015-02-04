class AddExplorerIdToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :explorer_id, :integer
  end
end
