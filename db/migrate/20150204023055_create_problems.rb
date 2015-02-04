class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :exploration_id
      t.string :title
      t.text :description
      t.text :problem_one
      t.text :problem_two
      t.text :problem_three

      t.timestamps
    end
  end
end
