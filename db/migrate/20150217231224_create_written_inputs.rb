class CreateWrittenInputs < ActiveRecord::Migration
  def change
    create_table :written_inputs do |t|
      t.integer :user_id
      t.integer :exploration_id
      t.text :written_input
      t.integer :step

      t.timestamps
    end
  end
end
