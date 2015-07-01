ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

ActiveRecord::Migration.maintain_test_schema!

