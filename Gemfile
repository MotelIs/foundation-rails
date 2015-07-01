source 'https://rubygems.org'

ruby '2.2.2'

#gems that are followed by *U-[context]* require manual changes after cloning.
gem 'airbrake' # *U-api key*
gem 'active_model_serializers', "~> 0.9.x"
gem 'active_hash_relation'
gem 'bcrypt'
gem 'doorkeeper'
gem 'pg'
gem 'pundit'
# May be required to specify the path to the 'pg_config' program installed with Postgres:
#$ bundle config build.pg --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.4/bin/pg_config
gem 'rack-cors'
gem 'rails', '4.2.1'
gem 'redis'
gem 'redis-objects'
gem 'responders'
gem 'rspec-api_helpers', github: 'kollegorna/rspec-api_helpers'
gem 'sidekiq'
gem 'unicorn'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'spring', '~> 1.3.5'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'mock_redis'
  gem 'pry-rails'
  gem 'timecop'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.2.1'
  gem 'shoulda-matchers'
end
