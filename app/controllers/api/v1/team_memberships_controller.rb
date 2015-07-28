class Api::V1::TeamMembershipsController
	before_filter :can_create?, only: :create

	def create
		@team.save
		render :json, @membership
	end

	def show
	end

	def update
	end

	def destroy
	end

	private

	def create_params
		params.require(:team_membership).permit(:user_id, :team_id, :role)
	end

	def can_create?
		@membership = TeamMembership.new(create_params)
			return render_unauthorized unless guardian.can_create_membership?(@membership)
	end
end