# frozen_string_literal: true

require 'rails'
require 'active_support/core_ext'
require 'active_support/hash_with_indifferent_access'
require 'newebpay-turbo'
require 'timecop'
require 'webmock/rspec'
require 'vcr'
require 'dotenv'

Dotenv.overload '.env.test'

Newebpay.configure do |configure|
  configure.merchant_id = ENV.fetch('MerchantID', nil)
  configure.hash_iv = ENV.fetch('HashIV', nil)
  configure.hash_key = ENV.fetch('HashKey', nil)
  configure.version = ENV.fetch('Version', nil)
end

Timecop.freeze(Time.local(2022, 7, 4, 11, 23, 0))

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end
