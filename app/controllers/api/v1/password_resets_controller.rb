class Api::V1::PasswordResetsController < Api::V1::BaseController
  skip_before_filter :doorkeeper_authorize!
  before_filter :find_user_by_key

  def create
    @user.password = creation_params[:password]
    @user.password_confirmation = creation_params[:password_confirmation]
    @user.partially_registered = false
    if @user.valid?
      @user.reset_password_sent_at = nil
      @user.reset_password_token = nil
      @user.save
    end
    respond_with :api_v1, @user
  end

  private

  def creation_params
    params.require(:password_reset).permit(:password, :password_confirmation, :key)
  end

  def find_user_by_key
    @user = User.where(reset_password_token: creation_params[:key]).first
    return render_missing unless @user.present?
    return render_expired unless @user.reset_password_sent_at > 6.hours.ago
  end

  def render_missing
    render_error 'Unable to find a valid password reset attempt'
  end

  def render_expired
    render_error 'The password reset request has expired'
  end

  def render_error message
    render json: { errors: {key: [message]}}, status: 422
  end
end
