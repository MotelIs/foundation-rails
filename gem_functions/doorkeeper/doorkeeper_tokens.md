#DOORKEEPER: OAuth2 Provider Functionality

https://github.com/doorkeeper-gem/doorkeeper

#ROUTE CONSTRAINTS

You can leverage the "Doorkeeper.authenticate" facade to easily extract a Doorkeeper::OAuth::Token based on the current request. You can then ensure that token is still good, find its associated #resource_owner_id, etc.

`module Constraint
  class Authenticated

    def matches?(request)
      token = Doorkeeper.authenticate(request)
      token && token.accessible?
    end

  end
end`

#ACCESS TOKEN SCOPES

You can also require the access token to have specific scopes in certain actions:

First configure the scopes in: initializers/doorkeeper.rb

`Doorkeeper.configure do
  default_scopes :public # if no scope was requested, this will be the default
  optional_scopes :admin, :write
end`

And in your controllers:

`class Api::V1::ProductsController < Api::V1::ApiController
  before_action -> { doorkeeper_authorize! :public }, only: :index
  before_action only: [:create, :update, :destroy] do
    doorkeeper_authorize! :admin, :write
  end
end`

[NOTE] There is a logical OR between multiple required scopes.

In above example,
  `doorkeeper_authorize! :admin, :write`
means that the access token is required to have
either ":admin" scope or ":write" scope,
but not need have both of them.

If want to require the access token to have multiple scopes at the same time, use multiple doorkeeper_authorize!, for example:

`class Api::V1::ProductsController < Api::V1::ApiController
  before_action -> { doorkeeper_authorize! :public }, only: :index
  before_action only: [:create, :update, :destroy] do
    doorkeeper_authorize! :admin
    doorkeeper_authorize! :write
  end
end`

In above example, a client can call :create action only if its access token have both ":admin" and ":write" scopes.

#CUSTOM ACCESS TOKEN GENERATOR

By default a 32 bit access token will be generated.

If you require a custom token, such as JWT, specify an object that responds to .generate(options = {}) and returns a string to be used as the token:

`Doorkeeper.configure do
  access_token_generator "Doorkeeper::JWT"
end`




