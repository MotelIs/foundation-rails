module OAuthSupport
  def stub_oauth_authenticated_user
    build_stubbed(:user).tap do |user|
      allow(User).to receive(:find).and_return(user)
      access_token = FactoryGirl.build_stubbed(:oauth_access_token, user: user)
      allow(Doorkeeper::OAuth::Token).to receive(:authenticate).
        and_return(access_token)
    end
  end

  def authenticate_with(access_token)
    allow(Doorkeeper::OAuth::Token).to receive(:authenticate).
      and_return(access_token)
  end

  def authenticate_as(user)
    access_token = FactoryGirl.build_stubbed(:oauth_access_token, resource_owner_id: user.id)
    authenticate_with(access_token)
  end

  def authenticate_with(access_token)
    allow(Doorkeeper::OAuth::Token).to receive(:authenticate).
      and_return(access_token)
  end
end

RSpec.configure do |config|
  config.include OAuthSupport
end
