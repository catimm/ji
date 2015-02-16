class AddInvitedForExplorationIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :invited_for_exploration_id, :integer
  end
end
