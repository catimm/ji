class CreateExplorations < ActiveRecord::Migration
  def change
    create_table :explorations do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :picture
      t.integer :completions_required

      t.timestamps
    end
  end
end
