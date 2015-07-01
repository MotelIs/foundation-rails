#DOTENV: Shim to load environmental variables from .env into ENV in development

[link][1]

Inspired by the [Twelve-Factor App][2]

[NOTE]:
dotenv is initialized during the "before_configuration" callback,
which is fired when the Application constant is defined in config/application.rb
with "class Application < Rails::Application. If you need it to be initialized sooner,
manually call:
config/application.rb:
`Bundler.require(*Rails.groups)
Dotenv::Railtie.load
HOSTNAME = ENV['HOSTNAME']`

If you use gems that require environment variables to be set before they are loaded, then list dotenv-rails in the Gemfile before those other gems and require dotenv/rails-now.

`gem 'dotenv-rails', :require => 'dotenv/rails-now'
gem 'gem-that-requires-env-variables'`
[/NOTE]

#USAGE
.env:
`S3_BUCKET=YOURS3BUCKET
SECRET_KEY=YOURSECRETKEYGOESHERE`

If you need multiline variables, for example private keys, you can double quote strings and use the \n character for newlines:

PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----\nHkVN9…\n-----END DSA PRIVATE KEY-----\n"

You may also add export in front of each line so you can source the file in bash:

`export S3_BUCKET=YOUYS3BUCKET
export SECRET_KEY=YOURSECRETKEYGOESHERE`

Whenever your application loads, these variables will be available in ENV:

config.fog_directory  = ENV['S3_BUCKET']

[NOTE]: dotenv was originally created to load configuration variables in ENV in development.


[1]: https://github.com/bkeepers/dotenv
[2]: http://12factor.net/
