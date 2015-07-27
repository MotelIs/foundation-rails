class Api::V1::TeamsController < Api::V1::BaseController
	  skip_before_filter :doorkeeper_authorize!, only: [:create]
	  # before_filter :is_admin?, only: [:create]
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
    @team_user = TeamUser.create(user: current_user, team: @team)
    @team_user.save
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
    params.require(:team).permit(:name)
  end

  def find_user
    @user == current_user
  end

  def is_admin?
    return render_unauthorized unless current_user.admin?
  end
end
