# frozen_string_literal: true

require_relative 'config'
require_relative 'errors'
require_relative './AES/cryptographic'
require_relative './SHA256/cryptographic'

module Newebpay
  class Refund
    attr_accessor :trade_info

    def initialize(order_number: nil, amount: nil)
      unless order_number && amount
        raise Newebpay::PaymentArgumentError, 'Please make sure that your arguments (order_number, amount) are filled in correctly'
      end

      @key = Config.options[:HashKey]
      @iv = Config.options[:HashIV]
      @order_number = order_number
      @amount = amount
      set_trade_info
      @AES_trade_info = AES::Cryptographic.new(url_encoded_trade_info).encrypt
    end

    def required_parameters
      {
        MerchantID_: Config.options[:MerchantID],
        PostData_: @AES_trade_info
      }
    end

    private

    def url_encoded_trade_info
      URI.encode_www_form(@trade_info)
    end

    def set_trade_info
      @trade_info = {
        RespondType: 'JSON',
        Version: '1.1',
        MerchantOrderNo: @order_number,
        Amt: @amount.to_i,
        TimeStamp: Time.now.to_i.to_s,
        IndexType: 1,
        CloseType: 2 
      }
    end
  end
end
