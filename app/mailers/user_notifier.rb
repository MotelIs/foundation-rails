class UserNotifier < ApplicationMailer
  default from: 'any_from_address@example.com'

  def send_signup_email(user)
    @user = user
    mail( to: @user.email,
      subject: 'Thanks for signing up!',
      content_type: "text/html"
    )
  end
end
