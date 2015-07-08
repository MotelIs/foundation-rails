require 'rails_helper'

RSpec.describe Api::V1::PasswordRecoveriesController, type: :controller do

  describe '.create' do
    before do
      @attrs = attributes_for(:user)
      @attrs[:email] = "valid_email@gmail.com"
      @user = User.create(@attrs)
      @user.request_password_reset
    end

    it 'Delivers a reset password mailer to the user' do
      expect { @user.send_password_reset_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'specifies the subject' do
      email = reset_password_email_for
      expect(email.subject).to eq "Reset Your Password on Foundation"
    end

    it 'sends only to the user' do
      rando = create(:user)
      email = reset_password_email_for

      expect(email.to).to include @user.email
      expect(email.to).not_to include rando
    end

    it 'should include a link to the invitation' do
      email = reset_password_email_for
      expect(email.body).to include(
        api_v1_password_resets_path(token: @user.reset_password_token)
      )
    end
  end

  def reset_password_email_for
    PasswordMailer.reset_password(@user)
  end
end
