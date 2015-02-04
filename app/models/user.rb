# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  has_many :authentications
  has_many :videos
  has_many :explorers
  has_many :exploration_users
  has_many :exploration_invitations
  
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
  
end
