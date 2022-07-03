# frozen_string_literal: true

require_relative 'config'
require_relative 'errors'
require_relative './AES/cryptographic'
require_relative './SHA256/cryptographic'
require 'net/http'
require 'json'

module Newebpay
  class Refund
    attr_accessor :refund_info
    attr_reader :response

    def initialize(order_number: nil, amount: nil, cancel: false)
      unless order_number && amount
        raise Newebpay::PaymentArgumentError, 'Please make sure that your arguments (order_number, amount) are filled in correctly'
      end

      @key = Config.options[:HashKey]
      @iv = Config.options[:HashIV]
      @order_number = order_number
      @amount = amount
      @cancel = cancel
      set_refund_info
      @post_data = AES::Cryptographic.new(url_encoded_refund_info).encrypt
    end

    def request!
      uri = URI('https://ccore.newebpay.com/API/CreditCard/Close')
      res = Net::HTTP.post_form(uri, 'MerchantID_': Config.options[:MerchantID], 'PostData_': @post_data)
      @response = JSON.parse(res.body)
    end

    def success?
      return if @response.nil?

      @response['Status'] == 'SUCCESS'
    end

    private

    def url_encoded_refund_info
      URI.encode_www_form(@refund_info)
    end

    def set_refund_info
      @refund_info = {
        RespondType: 'JSON',
        Version: '1.1',
        MerchantOrderNo: @order_number,
        Amt: @amount.to_i,
        TimeStamp: Time.now.to_i.to_s,
        IndexType: 1,
        CloseType: 2
      }

      return unless @cancel

      @refund_info.merge!(Cancel: 1)
    end
  end
end
