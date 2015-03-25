# == Schema Information
#
# Table name: exploration_users
#
#  id                 :integer          not null, primary key
#  exploration_id     :integer
#  user_id            :integer
#  started            :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  status             :string(255)
#  completed          :datetime
#  invited_by_user_id :integer
#  user_chosen        :string(255)
#  reminders          :integer
#  last_reminder_sent :datetime
#

class ExplorationUser < ActiveRecord::Base
  include DeviseInvitable::Inviter
  
  belongs_to :user
  belongs_to :exploration, counter_cache: true
  
  def self.project_reminder_email
    feedback_started = ExplorationUser.where("started IS NOT ? AND completed IS ? AND reminders < ?", nil, nil, 3)
    feedback_started.each do |d|
      Rails.logger.debug("Started user info: #{d.inspect}")
      if d.reminders < 3
        invited = User.find(d.user_id)
        Rails.logger.debug("Invited info: #{invited.inspect}")
        description = Exploration.find(d.exploration_id)
        if d.reminders == 0
          sign_up = ((Time.now - d.started)/1.day).round
          if sign_up > 3
            UserMailer.project_reminder_email(invited, description.short_description).deliver
            d.update_attribute :last_reminder_sent, Time.now.utc
            d.update_attribute :reminders, 1
          end
        else 
          last_sent = ((Time.now - d.last_reminder_sent)/1.day).round
          Rails.logger.debug("Days ago last sent: #{last_sent.inspect}")
          if last_sent > 3
            UserMailer.project_reminder_email(invited, description.short_description).deliver
            d.update_attribute :last_reminder_sent, Time.now.utc
            d.increment!(:reminders)
          end
        end
      end
    end
    Rails.logger.debug("Exploration user started users: #{started.inspect}")
  end
end
