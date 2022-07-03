# frozen_string_literal: true

require_relative '../config'

module Newebpay
  module AES
    class Cryptographic
      def initialize(data)
        @key = Config.options[:HashKey]
        @iv = Config.options[:HashIV]
        @data = data
      end

      def encrypt
        encode(@data)
      end

      def decrypt
        decode(@data)
      end

      private

      def decode(data)
        encrypted_data = [data].pack("H*")
        decipher = OpenSSL::Cipher::AES256.new(:CBC)
        decipher.decrypt
        decipher.padding = 0
        decipher.key = @key
        decipher.iv = @iv
        data = decipher.update(encrypted_data) + decipher.final
        strip_padding(data)
      end

      def encode(data)
        cipher = OpenSSL::Cipher::AES256.new(:CBC)
        cipher.encrypt
        cipher.key = @key
        cipher.iv = @iv
        cipher.padding = 0
        padding_data = add_padding(data)
        encrypted = cipher.update(padding_data) + cipher.final
        encrypted.unpack('H*').first
      end

      def add_padding(data, block_size = 32)
        pad = block_size - (data.length % block_size)
        data + (pad.chr * pad)
      end 

      def strip_padding(data)
        slast = data[-1].ord
        slastc = slast.chr
        padding_index = /#{slastc}{#{slast}}/ =~ data
        if !padding_index.nil?
          data[0, padding_index]
        else
          false
        end
      end
    end
  end
end
