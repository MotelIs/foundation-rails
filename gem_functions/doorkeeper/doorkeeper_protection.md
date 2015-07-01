#DOORKEEPER: OAuth2 Provider Functionality

https://github.com/doorkeeper-gem/doorkeeper

#OAUTH (AKA: Your API Endpoint)

To protect your API with OAuth, you just need to setup before_actions specifying the actions you want to protect. For example:

`class Api::V1::ProductsController < Api::V1::ApiController
  before_action :doorkeeper_authorize! # Require access token for all actions

  # your actions
end`

You can pass any option before_action accepts, such as if, only, except, and others.


