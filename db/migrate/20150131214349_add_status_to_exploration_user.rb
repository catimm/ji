class AddStatusToExplorationUser < ActiveRecord::Migration
  def change
    add_column :exploration_users, :status, :integer
  end
end
