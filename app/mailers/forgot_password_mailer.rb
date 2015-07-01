class ForgotPasswordMailer < BaseMailer

  def reset_password user
    @user = user

    mail(
      to: @user.email,
      subject: "Reset Your Password"
    )
  end
end
