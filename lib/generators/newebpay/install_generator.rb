# frozen_string_literal: true

require 'generators/newebpay/helpers'
require 'rails/generators/base'

module Newebpay
  module Generators
    # Generate initailize file of newebpay config
    class InstallGenerator < Rails::Generators::Base
      include Newebpay::Generators::Helpers

      source_root File.expand_path('templates', __dir__)

      def copy_initializer_file
        template 'initializer.rb', newebpay_config_path
      end
    end
  end
end
