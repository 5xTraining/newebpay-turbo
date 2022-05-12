# frozen_string_literal: true

require_relative 'config'
require_relative 'errors'
require_relative './AES/cryptographic'

module Newebpay
  class Response
    attr_reader :status, :message, :result, :order_no, :trans_no, :pay_bank_code, :payer_account5_code, :card6_no, :card4_no, :paid_at

    def initialize(data)
      response = AES::Cryptographic.new(data).decrypt

      @status = response["Status"]
      @message = response["Message"]
      @result = response["Result"]
      @order_no = @result["MerchantOrderNo"]
      @trans_no = @result["TradeNo"]
      @pay_bank_code = @result["PayBankCode"]
      @payer_account5_code = @result["PayerAccount5Code"]
      @card6_no = @result["Card6No"]
      @card4_no = @result["Card4No"]
      @paid_at = @result["PayTime"]
    end

    def success?
      status === "SUCCESS"
    end
  end
end
