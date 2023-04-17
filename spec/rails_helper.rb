require 'spec_helper'
require 'active_record'
require 'logger'

Rails.logger = Logger.new(STDOUT)
Rails.logger.level = Logger::DEBUG

RSpec.configure do |config|
end