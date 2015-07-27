class Api::V1::TeamsController < Api::V1::BaseController
	  skip_before_filter :doorkeeper_authorize!, only: [:create]
	  before_filter :can_see?, only: [:create]

  def index
  	teams = Team.all
  	render json: teams
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end

  def create
    @team = Team.create(create_params)
    if @team.valid?
      @team_user = TeamUser.create(user: @user, team: @team)
      @team_user.save
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

  def can_see?
    find_user
    return render_unauthorized unless @user != nil
  end

  def create_params
    params.require(:team).permit(:name)
  end

  def find_user
    @user = current_user
  end

  def is_admin?
    return render_unauthorized unless current_user.admin?
  end
end
