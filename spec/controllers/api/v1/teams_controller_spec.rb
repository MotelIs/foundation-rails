require 'rails_helper'

describe Api::V1::TeamsController do
  before do
    @user = create(:user)
    @admin = create(:admin)
  end

  describe '#index' do
    before do
      @teams = []
      3.times do
        @teams << create(:team)
      end
    end

    it 'should not return a list of teams for a guest' do
      get :index, format: :json
      expect(response.status).to eq 401
    end

    it 'should allow a normal user to view a list' do
      authenticate_as @user
      get :index, format: :json
      expect(response.status).to eq 200
    end


    it 'should return a list of teams' do
      authenticate_as @user
      get :index, format: :json
      expect(json_response['data'].length).to eq Team.count
    end
  end

  describe '#show' do
    before do
      @team = create(:team)
    end

    it 'should not allow a guest to see a specific team' do
      get :show, id: @team.id, format: :json
      expect(response).to render_unauthorized
    end

    it 'should allow a user to see a specific team' do
      authenticate_as @user
      get :show, id: @team.id, format: :json
      expect(response.status).to eq 200
      expect(json_response).to include('team')
      expect(json_response['team']['id']).to eq @team.id
    end
  end

  describe '#create' do
    before do
      @attrs = attributes_for :team
    end

    it 'should allow a user to create a team' do
      authenticate_as @user
      post :create, team: @attrs, format: :json
      expect(response.status).to eq 200
    end

    it 'should not render the page for a guest' do
      post :create, team: @attrs, format: :json
      expect(response.status).to eq 401
    end

    it 'should respond with a created team' do
      authenticate_as @admin
      expect {
        post :create, team: {
          name: 'purple'
        }, format: :json
      }.to change(Team, :count).by(1)

      expect(json_response['data']['type']).to include('teams')
    end

    it "should give the creator the role of 'owner'" do
      authenticate_as @user
      post :create, team: @attrs, format: :json
      expect(@user.role).to eq "owner"
    end
  end

  describe '#update' do
    before do
      @admin = create(:admin)
      @attrs = attributes_for(:team)
      @team = Team.create(@attrs)
    end

    it 'renders unauthorized for an unauthorized user' do
      authenticate_as @user
      put :update, id: @team.id, team: @team, format: :json
      expect(response).to render_unauthorized
    end

    it 'updates a team for a leader' do
      authenticate_as @admin
      name = "blue"
      @attrs[:name] = name
      put :update, id: @team.id, team: @attrs, format: :json
      expect(json_response['data']['type']).to include('teams')
      expect(json_response['data']['attributes']['name']).to eq name
    end
  end

#     it 'renders an update for a authorized user' do
#       authenticate_as @admin
#       @attrs[:admin] = true
#       put :update, id: @user.id, user: @attrs, format: :json
#       expect(response.status).to eq 200
#     end
#   end

  describe '#destroy' do
    before do
      @admin = create(:admin)
      @user = create(:user)
      @team = create(:team)
    end

    it 'should not allow unauthorized users to delete a team' do
      authenticate_as @user
      delete :destroy, id: @team.id, format: :json
      expect(response).to render_unauthorized
    end

    it 'should allow a user to delete their own record' do
      authenticate_as @user
      expect {
        delete :destroy, id: @user.id, format: :json
      }.to change(User, :count).by(-1)
    end
  end
end

#     it 'should allow an admin to delete the record' do
#       authenticate_as @admin
#       expect {
#         delete :destroy, id: @user.id, format: :json
#       }.to change(User, :count).by(-1)
#     end
#   end
# end
