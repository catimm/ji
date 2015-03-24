class SecondReminderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(invited, inviter, description, link)
    invited_user = User.find(invited.id)
    if invited_user.invitation_token IS NULL && invited_user.reminders == 1
      UserMailer.signup_reminder_email(invited, inviter, description, link).deliver
      invited_user.update_attribute :last_reminder_sent, Time.now.utc
      invited_user.increment!(:reminders)
    end
  end
end