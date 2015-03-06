class UserMailer < ActionMailer::Base

  def mandrill_client_dev
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_DEV_APIKEY']
  end
  
  def mandrill_client_prod
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_DEV_APIKEY']
  end
  
  def owner_invite_email(invited, inviter, description, time, link)
    @invited = invited
    @inviter = inviter
    @description = description
    @time = time
    @link = link
    mail( :to => invited.email,
    :from => 'invite-no-reply@bonu.co',
    :fromname => inviter.first_name+' ('+inviter.email+')',
    :subject => 'Check out my '+description+' project on bonu' )
    # url = root_url+"users/invitation/accept?invitation_token="
    website = root_url
  end
  
  def friend_invite_email(invited, inviter, description, time, link)
    @invited = invited
    @inviter = inviter
    @description = description
    @time = time
    @link = link
    mail( :to => invited.email,
    :from => 'invite-no-reply@bonu.co',
    :fromname => inviter.first_name+' ('+inviter.email+')',
    :subject => "Check out my friend's "+description+" project on bonu" )
    # url = root_url+"users/invitation/accept?invitation_token="
    website = root_url
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
    @user = user
    mail( :to => user.email,
    :from => 'welcome@bonu.co',
    :subject => 'Welcome to bonu!' )
    Rails.logger.debug("User info is: #{user.inspect}")
  end  
end
