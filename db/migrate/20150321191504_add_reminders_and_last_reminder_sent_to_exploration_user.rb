class AddRemindersAndLastReminderSentToExplorationUser < ActiveRecord::Migration
  def change
    add_column :exploration_users, :reminders, :integer
    add_column :exploration_users, :last_reminder_sent, :datetime
  end
end
