class FirstReminderWorker
  include Sidekiq::Worker
  
  def perform(invited_id, inviter, description, link)
    invited_user = User.find(invited_id)
    if invited_user.invitation_token IS NULL && invited_user.reminders == 0
      UserMailer.signup_reminder_email(invited_user.first_name, invited_user.email, inviter, description, link).deliver
      invited_user.update_attribute :last_reminder_sent, Time.now.utc
      invited_user.increment!(:reminders)
    end
  end
end