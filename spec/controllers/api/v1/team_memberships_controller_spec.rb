require 'rails_helper'

describe Api::V1::TeamMembershipsController do
	
	describe '#create' do
		before do
			@team = create(:team)
			@member = create(:user)
			@lead = create(:user)
			@owner = create(:user)
		end

		def create_params
			{
				team_membership: {
					role: :owner,
					team_id: @team.id,
					user_id: @member.id
				},
				format: :json
			}
		end

		context 'creating a team member' do

			it 'should not allow an unassociated user' do
        @user = create(:user)
        authenticate_as(@user)
        post :create, create_params
        expect(response).to render_unauthorized
      end

			it 'should allow staff members' do
        @team.leads << @lead
        authenticate_as @lead
        post :create, create_params
				expect(json_response['data']['type']).to include('team_memberships')
      end

			it 'should contain a new membership' do
				@team.owners << @owner
				authenticate_as @owner
				post :create, create_params
				expect(json_response['data']['type']).to include('team_memberships')
			end
		end
	end
end