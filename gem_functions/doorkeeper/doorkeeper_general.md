#DOORKEEPER: OAuth2 Provider Functionality

[link][1]

#SETUP

`rails generate doorkeeper:install`

By default doorkeeper is configured to use active record, so to start you have to generate the migration tables:

`rails generate doorkeeper:migration`

#ROUTES

The Doorkeeper generation will automatically modify routes.rb:

`Rails.application.routes.draw do
  use_doorkeeper
  # your routes
end`

#ROUTE LIST

GET       /oauth/authorize/:code
GET       /oauth/authorize
POST      /oauth/authorize
DELETE    /oauth/authorize
POST      /oauth/token
POST      /oauth/revoke
resources /oauth/applications
GET       /oauth/authorized_applications
DELETE    /oauth/authorized_applications/:id
GET       /oauth/token/info

#AUTHENTICATING

You need to configure Doorkeeper in order to provide resource_owner model and authentication block initializers/doorkeeper.rb

`Doorkeeper.configure do
  resource_owner_authenticator do
    User.find_by_id(session[:current_user_id]) || redirect_to(login_url)
  end
end`

[1]: https://github.com/doorkeeper-gem/doorkeeper
