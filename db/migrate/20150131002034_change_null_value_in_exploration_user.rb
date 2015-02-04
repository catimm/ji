class ChangeNullValueInExplorationUser < ActiveRecord::Migration
  def change
    change_column :exploration_users, :completed, :string, :null => true
  end
end
