# Load the Rails environment and testing dependencies
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'factory_bot_rails'
require 'spec_helper'

# Load all support files
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# Configure RSpec
RSpec.configure do |config|
  # Include FactoryBot methods
  config.include FactoryBot::Syntax::Methods

  # Use the dummy app's database schema
  ActiveRecord::Migration.check_pending!
  ActiveRecord::Migration.maintain_test_schema!

  # Use transactions to speed up tests
  config.use_transactional_fixtures = true
end
