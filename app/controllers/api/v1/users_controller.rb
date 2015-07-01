class Api::V1::UsersController < Api::V1::BaseController
  skip_before_filter :doorkeeper_authorize!, only: [:create]
  before_filter :is_admin?, only: [:index]
  before_filter :find_user, except: [:create, :index]
  before_filter :can_see?, only: [:show]
  before_filter :can_edit?, only: [:update, :destroy]

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render(json: Api::V1::UserSerializer.new(user).to_json)
  end

  def create
    @user = User.create(create_params)
    if @user.valid?
      UserNotifier.send_signup_email(@user).deliver_now
      render(
        json: @user,
        serializer: Api::V1::UserRegistrationSerializer
      )
    else
      render_json_error "invalid user submission."
    end
  end

  def update
    if current_user.admin? || current_user == @user
      @user.update_attributes(update_params)
      render(
        json: @user,
        status: 200,
        location: api_v1_user_path(@user.id)
      )
    else
      render_unauthorized
    end
  end

  def destroy
    @user.delete
    render(
      json: @user
    )
  end

  private

  def can_edit?
    find_user
    return render_unauthorized unless guardian.can_edit?(@user)
  end

  def can_see?
    find_user
    return render_unauthorized unless guardian.can_see?(@user)
  end

  def create_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def is_admin?
    return render_unauthorized unless current_user.admin?
  end

  def update_params
    update_params = create_params

    if update_params[:password].blank? &&
      update_params[:password_confirmation].blank?

      update_params.delete :password
      update_params.delete :password_confirmation
    end

    if !guardian.is_admin?
      update_params.delete :admin
    end
    update_params
  end
end
