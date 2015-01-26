class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :uuid
      t.string :url
      t.string :completed

      t.timestamps
    end
  end
end
