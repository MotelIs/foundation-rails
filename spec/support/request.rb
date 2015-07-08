module Request

  def send_as(user = nil)
    user ||= create(:user)
    application = Doorkeeper::Application.create!(:name => "MyApp", :redirect_uri => "urn:ietf:wg:oauth:2.0:oob")
    access_token = Doorkeeper::AccessToken.create!(:application_id => application.id, :resource_owner_id => user.id)
    Rack::MockRequest::DEFAULT_ENV['HTTP_AUTHORIZATION']= "Bearer #{access_token.token}"
    access_token.token
  end

  def create_application()
    Doorkeeper::Application.create!(:name => "MyApp", :redirect_uri => "urn:ietf:wg:oauth:2.0:oob")
  end

  def json_response
    JSON.parse(response.body)
  end

  def json_response_error_message
    json_response['error']
  end
end

RSpec.configure do |config|
  config.include Request
  config.include Request, type: :controller
end
