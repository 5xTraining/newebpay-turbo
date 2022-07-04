# frozen_string_literal: true

require_relative '../config'

module Newebpay
  module SHA256
    class Cryptographic
      def initialize(data)
        @data = data
      end

      def encrypt
        encode(@data)
      end

      private

      def encode(data)
        key = Config.options['HashKey']
        iv = Config.options['HashIV']
        encode_string = "HashKey=#{key}&#{data}&HashIV=#{iv}"
        Digest::SHA256.hexdigest(encode_string).upcase
      end
    end
  end
end
