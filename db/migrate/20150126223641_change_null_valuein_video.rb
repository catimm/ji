class ChangeNullValueinVideo < ActiveRecord::Migration
  def change
    change_column :videos, :completed, :string, :null => true
  end
end
