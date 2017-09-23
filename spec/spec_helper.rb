require 'simplecov'
require 'workday'
require 'virtus-rspec'

include Workday

SimpleCov.start

RSpec.configure do |config|
    
    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = :random
    
    # These two settings work together to allow you to limit a spec run
    # to individual examples or groups you care about by tagging them with
    # `:focus` metadata. When nothing is tagged with `:focus`, all examples
    # get run.
    config.filter_run :focus
    config.run_all_when_everything_filtered = true
  
    config.include Virtus::Matchers
end
