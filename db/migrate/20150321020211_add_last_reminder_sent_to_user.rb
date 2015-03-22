class AddLastReminderSentToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_reminder_sent, :datetime
  end
end
