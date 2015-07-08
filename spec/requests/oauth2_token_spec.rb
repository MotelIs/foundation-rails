require 'rails_helper'

describe "OAuth Tokens" do
  describe "POST api/v1/oauth/token" do
    it 'should return a 401 without user credentials' do
      post oauth_token_path
      expect(response.status).to eq(401)
    end

    it 'should return a 401 without a grant_type' do
      post oauth_token_path, {email: 'foo@email.com', password: 'foo__bar'}
      expect(response.status).to eq(401)
    end
  end

  describe 'GET /api/v1/oauth/token/info' do
    it 'should return a 401 for a request without a token' do
      get oauth_token_info_path
      expect(response.status).to eq(401)
    end

    it 'should return a hash of information about the token' do
      send_as
      get oauth_token_info_path
      expect(response).to be_success

      # json = JSON.parse(response.body)
      # expect(json).to include('resource_owner_id', 'expires_in_seconds', 'created_at')
    end
  end
end
