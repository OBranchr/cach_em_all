require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.order = "random"
end
