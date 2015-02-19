class UserMailer < ActionMailer::Base

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_APIKEY']
  end
  
  def invite_email(invited, inviter, description)
    url = root_url+"users/invitation/accept?invitation_token="+invited.raw_invitation_token
    Rails.logger.debug("Raw token is: #{url.inspect}")
    template_name = "invitation-email"
    template_content = []
    message = {
      to: [{email: invited.email}],
      merge_vars: [
        {rcpt: invited.email,
         vars: [
           {name: "invited", content: invited.first_name},
           {name: "inviter", content: inviter.first_name},
           {name: "inviter_email", content: inviter.email},
           {name: "link", content: url},
           {name: "description", content: description},
         ]}
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end
  
  def welcome_email(user)
    url = root_url+"users/"+user.id
    template_name = "welcome-email"
    template_content = []
    message = {
      to: [{email: user.email}],
      merge_vars: [
        {rcpt: user.email,
         vars: [
           {name: "user", content: user.first_name},
           {name: "link", content: url}
         ]}
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end  
end
