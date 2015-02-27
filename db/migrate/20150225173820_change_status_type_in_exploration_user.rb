class ChangeStatusTypeInExplorationUser < ActiveRecord::Migration
  def change
    change_column :exploration_users, :status, :string
  end
end
