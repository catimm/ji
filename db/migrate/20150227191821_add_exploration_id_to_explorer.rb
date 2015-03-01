class AddExplorationIdToExplorer < ActiveRecord::Migration
  def change
    add_column :explorers, :exploration_id, :integer
  end
end
