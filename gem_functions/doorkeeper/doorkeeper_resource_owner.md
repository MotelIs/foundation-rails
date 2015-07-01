#DOORKEEPER: OAuth2 Provider Functionality

https://github.com/doorkeeper-gem/doorkeeper

#AUTHENTICATED RESOURCE OWNER

If you want to return data based on the current resource owner,
  in other words,
the access token owner,
you may want to define a method in your controller that returns the resource owner instance:

`class Api::V1::CredentialsController < Api::V1::ApiController
  before_action :doorkeeper_authorize!
  respond_to    :json

  # GET /me.json
  def me
    respond_with current_resource_owner
  end

  private

  # Find the user that owns the access token
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end'

In this example, we're returning the credentials (me.json) of the access token owner.

#APPLICATIONS LIST

By default, the applications list (/oauth/applications) is public available. To protect the endpoint you should uncomment these lines:

# config/initializers/doorkeeper.rb:

`Doorkeeper.configure do
  admin_authenticator do |routes|
    Admin.find_by_id(session[:admin_id]) || redirect_to(routes.new_admin_session_url)
  end
end`

The logic is the same as the resource_owner_authenticator block.

[NOTE]: Since the application list is just a scaffold, it's recommended to either customize the controller used by the list or skip the controller at all.
