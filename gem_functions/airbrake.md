#AIRBRAKE: Captures and tracks application exceptions

[link] [1]

#OVERVIEW
Airbrake will POST uncaught exception data
to the Airbrake server specified in the environment.

This file should be checked into your version control system so that
it is deployed to your staging and product environments

#SETUP
From Foundation's RAILS_ROOT:

`$ rake gems:unpack GEM=airbrake`
`$ script/generate airbrake --api-key your_key_here`

The generator creates a file under
config/initializers/airbrake.rb, configuring Airbrake with the API key.

#IGNORED EXCEPTIONS:
*Exceptions raised from Rails environments named development, test or cucumber will be ignored by default.*

ActiveRecord::RecordNotFound
ActionController::RoutingError
ActionController::InvalidAuthenticityToken
CGI::Session::CookieStore::TamperedWithCookie
ActionController::UnknownHttpMethod
ActionController::UnknownAction
AbstractController::ActionNotFound
Mongoid::Errors::DocumentNotFound
ActionController::UnknownFormat

#METHODS:
clear list of ignored exceptions: `config.development_environments = []`
alter list of ignored exceptions: `config.ignore_only = []`

#MAINTAINERS
run test:
`$ ./script/integration_test.rb <api_key> <host>`
once passing change the version inside lib/airbrake/version.rb and push the new version with Changeling:
`$ changeling:change

[1]: https://github.com/airbrake/airbrake
