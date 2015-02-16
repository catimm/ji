class UserMailer < ActionMailer::Base

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_APIKEY']
  end
  
  def welcome_email(user)
    template_name = "welcome-email"
    template_content = []
    message = {
      to: [{email: user.email}],
      merge_vars: [
        {rcpt: user.email,
         vars: [
           {name: "user", content: user.first_name},
           {name: "link", content: user.id}
         ]}
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end  
end
