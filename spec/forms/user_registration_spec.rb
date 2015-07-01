require 'rails_helper'

describe UserRegistration do

  it { is_expected.to be_kind_of ActiveModel::Model }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_confirmation_of :password }
  it { should validate_presence_of :password_confirmation }

  it 'should allow valid emails' do
    emails = %w(scott@motel.is foo@gmail.com)
    emails.each do |e|
      should allow_value(e).for(:email)
    end
  end

  it 'should not allow invalid emails' do
    bad_emails = %w(foo foo@bar badgmail.com)
    bad_emails.each do |e|
      should_not allow_value(e).for(:email)
    end
  end

  it 'should ensure that the email is unique' do
    user = create(:user)
    new_params = creation_params email: user.email
    form = UserRegistration.new(new_params)
    expect(form.valid?).to eq false
  end

  def creation_params params={}
    {
      email: 'scott@motel.is',
      password: 'hitherescott',
      password_confirmation: 'hitherescott'
    }.merge params
  end
end
