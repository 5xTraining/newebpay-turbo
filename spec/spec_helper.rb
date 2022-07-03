# frozen_string_literal: true

require 'rails'
require "active_support/core_ext"
require 'active_support/hash_with_indifferent_access'
require "newebpay-turbo"
require 'timecop'
require 'webmock/rspec'
require 'vcr'
require "dotenv"

Dotenv.overload ".env.test" 

Newebpay::Config.options[:MerchantID] = ENV['MerchantID']
Newebpay::Config.options[:HashIV] = ENV['HashIV']
Newebpay::Config.options[:HashKey] = ENV['HashKey']
Newebpay::Config.options[:Version] = ENV['Version']

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end