class AddUserChosenToExplorationUser < ActiveRecord::Migration
  def change
    add_column :exploration_users, :user_chosen, :string
  end
end
