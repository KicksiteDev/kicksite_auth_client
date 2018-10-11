require 'simplecov'

SimpleCov.start do
  coverage_dir 'tmp/test-results/test-coverage'

  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Internal Libraries', 'lib'
  add_group 'Models', 'app/models'
end

require 'bundler/setup'
require 'kicksite_auth_client'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
