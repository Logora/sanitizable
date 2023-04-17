require 'bundler/setup'
require 'sanitizable'

# Load any additional gems you need for your tests here
require 'rspec/rails'
require 'shoulda/matchers'

# Configure RSpec
RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define(version: 1) do
      create_table :dummy_models do |t|
        t.string :name
        t.text :description
        t.timestamps null: false
      end
    end
  end

  config.after(:suite) do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define(version: 1) do
      drop_table :dummy_models
    end
  end

  config.include Sanitizable
end

# Configure shoulda-matchers to work with RSpec
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
