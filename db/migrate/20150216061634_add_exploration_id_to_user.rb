class AddExplorationIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :exploration_id, :integer
  end
end
