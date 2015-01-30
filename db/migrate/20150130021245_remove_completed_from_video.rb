class RemoveCompletedFromVideo < ActiveRecord::Migration
  def change
    remove_column :videos, :completed, :string
  end
end
