class AddExplorationIdToExplorationInvitation < ActiveRecord::Migration
  def change
    add_column :exploration_invitations, :exploration_id, :integer
  end
end
