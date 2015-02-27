class AddTimeToTakeToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :time_to_take, :integer
  end
end
