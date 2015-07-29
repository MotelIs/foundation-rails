class Api::V1::TeamsController < Api::V1::BaseController
  before_filter :can_administrate?, only: [:index, :create]
  before_filter :can_see?, only: [:show]
  before_filter :can_edit?, only: [:update, :destroy]
  before_filter :find_user, only: [:index]

  def index
  	@teams = Team.all
  	render json: @teams
  end

  def show
    render json: @team
  end

  def create
    @team = Team.create(team_params)
    render(
      json: @team
    )
  end

  def update
    @team = Team.find(params[:id])
    @team.update_attributes(team_params)
    render(
      json: @team,
      status: 200,
      location: api_v1_team_path(@team.id)
    )
  end

  def destroy
    @team.delete
    render(
      json: @team
    )
  end

  private

  def find_user
    @user = User.find(params[:id])
    return render_unauthorized unless guardian.can_see?(@user)
  end

  def can_administrate?
    return render_unauthorized unless guardian.is_admin?
  end

  def can_edit?
    @team = Team.find(params[:id])
    return render_unauthorized unless guardian.can_edit?(@team)
  end

  def can_see?
    @team = Team.includes(:team_memberships).find(params[:id])
    return render_unauthorized unless @user != nil
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
