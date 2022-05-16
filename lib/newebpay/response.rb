# frozen_string_literal: true

require_relative 'config'
require_relative 'errors'
require_relative './AES/cryptographic'

module Newebpay
  class Response
    attr_reader :status, :message, :result, :order_number, :trade_number, :ip, :card_number_first_six_code, :card_number_last_four_code,
                :escrow_bank, :auth_bank, :pay_way, :inst, :inst_first_price, :inst_each_price, :atm_pay_bank_code, :atm_payer_account_last_five_code,
                :paid_at

    def initialize(data)
      response = AES::Cryptographic.new(data['TradeInfo']).decrypt

      @status = response['Status']
      @message = response['Message']
      @result = response['Result']
      @order_number = @result['MerchantOrderNo']
      @trade_number = @result['TradeNo']
      @ip = @result['IP']
      @card_number_first_six_code = @result['Card6No']
      @card_number_last_four_code = @result['Card4No']
      @escrow_bank = @result['EscrowBank']
      @auth_bank = @result['AuthBank']
      @pay_way = @result['PaymentType']
      @inst = @result['Inst']
      @inst_first_price = @result['InstFirst']
      @inst_each_price = @result['InstEach']
      @atm_pay_bank_code = @result['PayBankCode']
      @atm_payer_account_last_five_code = @result['PayerAccount5Code']
      @paid_at = @result['PayTime']
    end

    def success?
      status === 'SUCCESS'
    end
  end
end
