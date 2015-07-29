require 'rails_helper'

describe Api::V1::TeamMembershipsController do
	
	describe '#create' do
		before do
			@team = create(:team)
			@member = create(:user)
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

		context 'creating a team owner' do

			it 'should not allow unauthorized users' do
				post :create, create_params
				expect(response).to render_unauthorized
			end

			it 'should not allow an unassociated user' do
        @user = create(:user)
        authenticate_as(@user)
        post :create, create_params
        expect(response).to render_unauthorized
      end

			it 'should not allow visitors' do
				post :create, create_params
				expect(response).to render_unauthorized
			end

			it 'should not allow staff members' do
        @user = create(:user)
        @pharmacy.leads << @user
        post :create, create_params
        expect(response).to render_unauthorized
      end

			it 'should not allow already established team members' do
				@user = create(:user)
				@team.member << @user
				post :create, create_params
				expect(response).to render_unauthorized
			end
		end

		it 'should contain a new membership' do
			admin = create(:admin)
			authenticate_as admin
			post :create, create_params
			expect(json_response).to include('team_membership')
		end
	end
end