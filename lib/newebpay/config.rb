# frozen_string_literal: true

module Newebpay
  module Config
    mattr_accessor :options

    OPTIONS = [
      'MerchantID',
      'HashKey',
      'HashIV',
      'RespondType',
      'Version',
      'LangType',
      'TradeLimit',
      'ExpireDate',
      'ReturnURL',
      'NotifyURL',
      'CustomerURL',
      'ClientBackURL',
      'EmailModify',
      'LoginType',
      'CREDIT',
      'ANDROIDPAY',
      'SAMSUNGPAY',
      'LINEPAY',
      'ImageUrl',
      'InstFlag',
      'CreditRed',
      'UNIONPAY',
      'WEBATM',
      'VACC',
      'BankType',
      'CVS',
      'BARCODE',
      'ESUNWALLET',
      'TAIWANPAY',
      'CVSCOM',
      'EZPAY',
      'EZPWECHAT',
      'EZPALIPAY',
      'LgsType'
    ]

    self.options = {}.with_indifferent_access

    OPTIONS.each do |option|
      duped_option = option.dup
      duped_option[0] = duped_option[0].downcase
      define_method("#{duped_option}=") do |value|
        self.options[option] = value        
      end
    end

    def configure
      yield self

      unless options[:MerchantID] && options[:HashKey] && options[:HashIV] && options[:Version] && options[:LoginType] && options[:RespondType]
        raise Newebpay::ConfigError, "Confirm that all required parameters in 'config/initializers/newebpay.rb' are filled in"
      end
    end
  end
end