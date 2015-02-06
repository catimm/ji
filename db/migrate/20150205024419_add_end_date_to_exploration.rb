class AddEndDateToExploration < ActiveRecord::Migration
  def change
    add_column :explorations, :end_date, :datetime
  end
end
