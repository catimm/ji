class ChangeExplorationUserCountColumnNameInExploration < ActiveRecord::Migration
  def change
    rename_column :explorations, :exploration_user_count, :exploration_users_count
  end
end
