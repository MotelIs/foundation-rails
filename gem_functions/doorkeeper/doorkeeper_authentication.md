#DOORKEEPER: OAuth2 Provider Functionality

https://github.com/doorkeeper-gem/doorkeeper

#AUTHENTICATING

You need to configure Doorkeeper in order to provide "resource_owner" model and authentication block: initializers/doorkeeper.rb

`Doorkeeper.configure do
  resource_owner_authenticator do
    User.find_by_id(session[:current_user_id]) || redirect_to(login_url)
  end
end`

LOCATIONS THAT ALLOW METHOD ACCESS:
Models
Session
Route helpers

LOCATIONS THE DO NOT ALLOW METHOD ACCESS:
ApplicationController

