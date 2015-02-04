class CreateExplorers < ActiveRecord::Migration
  def change
    create_table :explorers do |t|
      t.integer :user_id
      t.string :last_name
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
