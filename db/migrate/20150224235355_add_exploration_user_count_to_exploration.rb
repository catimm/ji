class AddExplorationUserCountToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :exploration_user_count, :integer
  end
end
