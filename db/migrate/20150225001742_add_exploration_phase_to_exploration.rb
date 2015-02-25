class AddExplorationPhaseToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :exploration_phase, :string
  end
end
