class Api::V1::PasswordRecoveriesController < Api::V1::BaseController
  before_filter :find_user_by_email
  skip_before_filter :doorkeeper_authorize!

  def create
    @user.request_password_reset
    PasswordMailer.reset_password(@user).deliver_now
    render json: nil
  end

  private

  def password_recoveries_params
    params.require(:password_recovery).permit(:email)
  end

  def find_user_by_email
    @user = User.where(email: password_recoveries_params[:email].first)
    render_missing unless @user.present?
  end

  def render_missing
    return render json: { errors: {email: ['is not associated with an account']}}, status: 422
  end
end
