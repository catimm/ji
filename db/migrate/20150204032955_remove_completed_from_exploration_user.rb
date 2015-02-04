class RemoveCompletedFromExplorationUser < ActiveRecord::Migration
  def change
    remove_column :exploration_users, :completed, :string
  end
end
