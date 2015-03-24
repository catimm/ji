class UserMailer < ActionMailer::Base

  def mandrill_client_dev
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_DEV_APIKEY']
  end
  
  def mandrill_client_prod
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_PROD_APIKEY']
  end
  
  def owner_invite_email(invited, inviter, description, time, link)
    # url = root_url+"users/invitation/accept?invitation_token="
    website = root_url
    Rails.logger.debug("Link is: #{link.inspect}")
    template_name = "owner-invite-email"
    template_content = []
    message = {
      to: [{email: invited.email}],
      inline_css: true,
      merge_vars: [
        {rcpt: invited.email,
         vars: [
           {name: "invited", content: invited.first_name},
           {name: "inviter", content: inviter.first_name},
           {name: "inviter_email", content: inviter.email},
           {name: "time", content: time},
           {name: "website", content: website},
           {name: "link", content: link},
           # {name: "token", content: invited.raw_invitation_token},
           {name: "description", content: description}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end
  
  def friend_invite_email(invited, inviter, description, time, link)
    # url = root_url+"users/invitation/accept?invitation_token="
    Rails.logger.debug("Link is: #{link.inspect}")
    website = root_url
    template_name = "friend-invite-email"
    template_content = []
    message = {
      to: [{email: invited.email}],
      inline_css: true,
      merge_vars: [
        {rcpt: invited.email,
         vars: [
           {name: "invited", content: invited.first_name},
           {name: "inviter", content: inviter.first_name},
           {name: "inviter_email", content: inviter.email},
           {name: "time", content: time},
           {name: "website", content: website},
           {name: "link", content: link},
           # {name: "token", content: invited.raw_invitation_token},
           {name: "description", content: description}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end
  
  def fof_invite_email(invited, inviter, description, time, link)
    # url = root_url+"users/invitation/accept?invitation_token="
    website = root_url
    template_name = "fof-invite-email"
    template_content = []
    message = {
      to: [{email: invited.email}],
      inline_css: true,
      merge_vars: [
        {rcpt: invited.email,
         vars: [
           {name: "invited", content: invited.first_name},
           {name: "inviter", content: inviter.first_name},
           {name: "inviter_email", content: inviter.email},
           {name: "time", content: time},
           {name: "website", content: website},
           {name: "link", content: link},
           # {name: "token", content: invited.raw_invitation_token},
           {name: "description", content: description}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end
  
  def general_invite_email(invited, inviter, description, time, link)
    # url = root_url+"users/invitation/accept?invitation_token="
    website = root_url
    template_name = "general-invite-email"
    template_content = []
    message = {
      to: [{email: invited.email}],
      inline_css: true,
      merge_vars: [
        {rcpt: invited.email,
         vars: [
           {name: "invited", content: invited.first_name},
           {name: "inviter", content: inviter.first_name},
           {name: "inviter_email", content: inviter.email},
           {name: "time", content: time},
           {name: "website", content: website},
           {name: "link", content: link},
           # {name: "token", content: invited.raw_invitation_token},
           {name: "description", content: description}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end
  
  def welcome_email(user)
    Rails.logger.debug("User info is: #{user.inspect}")
    url = root_url+"users/"
    template_name = "welcome-email"
    template_content = []
    message = {
      to: [{email: user.email}],
      inline_css: true,
      merge_vars: [
        {rcpt: user.email,
         vars: [
           {name: "user", content: user.first_name},
           {name: "link", content: url},
           {name: "id", content: user.id}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end
  
  def signup_reminder_email(invited_name, invited_email, inviter, description, link)
    website = root_url
    template_name = "signup-reminder-email"
    template_content = []
    message = {
      to: [{email: invited_email}],
      inline_css: true,
      merge_vars: [
        {rcpt: invited_email,
         vars: [
           {name: "invited", content: invited_name},
           {name: "inviter", content: inviter},
           {name: "website", content: website},
           {name: "link", content: link},
           {name: "description", content: description}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end
  
  def project_reminder_email(invited, description)
    # url = root_url+"users/invitation/accept?invitation_token="
    website = root_url
    template_name = "project-reminder-email"
    template_content = []
    message = {
      to: [{email: invited.email}],
      inline_css: true,
      merge_vars: [
        {rcpt: invited.email,
         vars: [
           {name: "invited", content: invited.first_name},
           {name: "website", content: website},
           {name: "description", content: description}
         ]}
      ]
    }
    if root_url == "https://bonu.herokuapp.com/"
      mandrill_client_prod.messages.send_template template_name, template_content, message
    else
      mandrill_client_dev.messages.send_template template_name, template_content, message
    end
  end 
end
