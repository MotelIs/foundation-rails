class Api::V1::TeamsController < Api::V1::BaseController
	  skip_before_filter :doorkeeper_authorize!, only: [:create]
	  before_filter :find_user, except: [:create, :index]

  def index
  	teams = Team.all
  	render json: teams
  end

  def show
    team = Team.find(params[:id])
    render(json: Api::V1::TeamSerializer.new(team).to_json)
  end

  def create
    @team = Team.create(create_params)
    if @team.valid?
      render(
        json: @team
      )
    else
      render_json_error "invalid team submission."
    end
  end

  def update
    if current_user.admin?
      @team.update_attributes(update_params)
      render(
        json: @team,
        status: 200,
        location: api_v1_team_path(@team.id)
      )
    else
      render_unauthorized
    end
  end

  def destroy
    @team.delete
    render(
      json: @team
    )
  end

  private

  def create_params
    params.require(:team).permit(:email, :password, :password_confirmation, :admin)
  end

  def find_user
    @team = User.find(params[:id])
  end

  def is_admin?
    return render_unauthorized unless current_user.admin?
  end

  def create_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin)
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
