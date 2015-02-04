class CreateExplorationUsers < ActiveRecord::Migration
  def change
    create_table :exploration_users do |t|
      t.integer :exploration_id
      t.integer :user_id
      t.datetime :started
      t.datetime :completed

      t.timestamps
    end
  end
end
