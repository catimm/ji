# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)      default(""), not null
#  encrypted_password         :string(255)      default("")
#  reset_password_token       :string(255)
#  reset_password_sent_at     :datetime
#  remember_created_at        :datetime
#  sign_in_count              :integer          default(0), not null
#  current_sign_in_at         :datetime
#  last_sign_in_at            :datetime
#  current_sign_in_ip         :inet
#  last_sign_in_ip            :inet
#  created_at                 :datetime
#  updated_at                 :datetime
#  first_name                 :string(255)
#  invitation_token           :string(255)
#  invitation_created_at      :datetime
#  invitation_sent_at         :datetime
#  invitation_accepted_at     :datetime
#  invitation_limit           :integer
#  invited_by_id              :integer
#  invited_by_type            :string(255)
#  invitations_count          :integer          default(0)
#  invited_for_exploration_id :integer
#  email_option               :string(255)
#  reminders                  :integer
#  last_reminder_sent         :datetime
#

class User < ActiveRecord::Base
  after_create :send_welcome_email
  attr_reader :raw_invitation_token
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  
  after_invitation_accepted :send_welcome_email
         
  has_many :authentications
  has_many :videos
  has_many :written_inputs
  has_many :explorers
  has_many :exploration_users
  has_many :explorations, through: :exploration_users
  
  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
    :uid => omni['uid'],
    :token => omni['credentials']['token'],
    :token_secret => omni['credentials']['secret'])
  end
  
  def update_with_password(params, *options)
   if encrypted_password.blank?
    update_attributes(params, *options)
   else
    super
   end
  end
  
  # let devise know that a password isn't required if the user logs in through LI
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def send_welcome_email
    if invitation_token.blank?
      Rails.logger.debug("Signup welcome email: #{sign_in_count.inspect}")
      UserMailer.welcome_email(self).deliver
    end
  end

  def self.reminder_email
    invited = User.where.not(invitation_token: nil).where("reminders < ?", 2)
    invited.each do |d|
      Rails.logger.debug("Invited user info: #{d.inspect}")
      if d.reminders < 2
        inviter = User.find(d.invited_by_id)
        Rails.logger.debug("Inviter info: #{inviter.inspect}")
        description = Exploration.find(d.invited_for_exploration_id)
        token = d.invitation_token {@raw_invitation_token}
        Rails.logger.debug("Token: #{token.inspect}")
        raw_token = d.raw_invitation_token 
        Rails.logger.debug("Raw Token: #{@raw_invitation_token.inspect}")
        if d.reminders == 0
          UserMailer.signup_reminder_email(self, inviter.first_name, description.short_description).deliver
        else 
          last_sent = ((Time.now - d.last_reminder_sent)/1.day).round
          Rails.logger.debug("Days ago last sent: #{last_sent.inspect}")
          if last_sent > 3
            UserMailer.signup_reminder_email(self, inviter.first_name, description.short_description).deliver
          end
        end
      end
    end
    Rails.logger.debug("User model Invited users: #{invited.inspect}")
  end

end
