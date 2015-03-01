class AddInvitedByUserIdToExplorationUser < ActiveRecord::Migration
  def change
    add_column :exploration_users, :invited_by_user_id, :integer
  end
end
