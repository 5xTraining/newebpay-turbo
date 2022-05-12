# frozen_string_literal: true

require 'rails'
require "active_support/core_ext"
require 'active_support/hash_with_indifferent_access'
require "newebpay/payment"
require "newebpay/response"
require "newebpay-rails"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
