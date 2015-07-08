class PasswordMailer < ActionMailer::Base

  def reset_password user
    @user = user
    mail(
      to: @user.email,
      from: "Foundation Team",
      subject: "Reset Your Password on Foundation"
    )
  end
end
