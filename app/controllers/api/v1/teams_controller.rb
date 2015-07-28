class Api::V1::TeamsController < Api::V1::BaseController
	  skip_before_filter :doorkeeper_authorize!, only: [:create]
	  before_filter :can_see?, only: [:create, :index, :show]
    before_filter :is_owner?, only: [:destroy]
    before_filter :is_valid?, only: [:update]

  def index
  	teams = Team.all
  	render json: teams
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end

  def create
    @team = Team.create(team_params)
    render(
      json: @team
    )
    if @team.save
      TeamMembership.new(user: @user, team: @team, role: "owner")
    end
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

  def is_owner?
    find_user
    binding.pry
    return render_unauthorized unless @user.role == "owner"
  end

  def is_valid?
    find_user
    return render_unauthorized unless @user.role == "owner" || @user.role == "lead"
  end

  def can_see?
    find_user
    return render_unauthorized unless @user != nil
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def find_user
    @user = current_user
  end

  def is_admin?
    return render_unauthorized unless current_user.admin?
  end
end
