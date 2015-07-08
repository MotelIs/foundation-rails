require 'rails_helper'

describe Api::V1::PasswordResetsController do
  describe '.create' do
    before do
      @user = create(:user)
      @user.request_password_reset
    end

    it 'returns an error for the key if no user exists' do
      post :create, password_reset: {key: ''}, format: :json
      expect(response.status).to eq 422
      expect(json_response['errors']).to include('key')
    end

    it 'returns an error if the request has expired' do
      @user.reset_password_sent_at = 2.weeks.ago
      @user.save

      post :create, password_reset: {key: @user.reset_password_token }, format: :json

      expect(response.status).to eq 422
      expect(json_response['errors']).to include('key')
      expect(json_response['errors']['key'].first).to include 'expired'
    end

    it 'returns validation errors for the password' do
      post :create, password_reset: params('foobar'), format: :json
      expect(response.status).to eq 422
      expect(json_response['errors']).to include('password')
    end

    it 'returns a valid user' do
      post :create, password_reset: params('foobarbaz'), format: :json
      expect(response.status).to eq 201
      expect(json_response['data']['type']).to include('user')
    end

    def params password
      {
        key: @user.reset_password_token,
        password: password,
        password_confirmation: password
      }
    end
  end
end
