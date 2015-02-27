class AddStepToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :step, :string
  end
end
