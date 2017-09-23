require 'simplecov'
require 'workday'
require 'virtus-rspec'

include Workday

SimpleCov.start

RSpec.configure do |config|
    config.order = "random"

    config.include Virtus::Matchers
end
