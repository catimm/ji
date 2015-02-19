class AddExplorationIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :exploration_id, :integer
  end
end
