class AddRemindersToUser < ActiveRecord::Migration
  def change
    add_column :users, :reminders, :integer
  end
end
