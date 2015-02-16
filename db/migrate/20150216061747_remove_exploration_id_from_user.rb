class RemoveExplorationIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :exploration_id, :integer
  end
end
