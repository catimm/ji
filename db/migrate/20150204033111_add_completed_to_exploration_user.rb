class AddCompletedToExplorationUser < ActiveRecord::Migration
  def change
    add_column :exploration_users, :completed, :datetime
  end
end
