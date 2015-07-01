require 'rails_helper'

describe UserRegistration do
  before do
    @user = create(:user)
  end

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('not an email address').for(:email) }

    it 'should not allow an existing user to be created' do
      params = creation_params(email: @user.email)
      @registration = UserRegistration.new(params)
      expect(@registration.valid?).to eq false
      expect(@registration.errors[:email].first).to include("email is already in use")
    end

    it 'should allow a new user to be created' do
      params = creation_params
      @registration = UserRegistration.new(params)
      expect(@registration.valid?).to eq true
    end
  end
end

def creation_params params = {}
  {
    email: 'kayla@motel.is',
    password: 'thisisapassword',
    password_confirmation: 'thisisapassword'
  }.merge params
end
