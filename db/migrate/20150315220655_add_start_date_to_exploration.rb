class AddStartDateToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :start_date, :datetime
  end
end
