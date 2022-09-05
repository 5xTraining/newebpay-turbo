# frozen_string_literal: true

module Newebpay
  module Config
    mattr_accessor :options

    OPTIONS = %w[
      MerchantID
      HashKey
      HashIV
      RespondType
      Version
      LangType
      TradeLimit
      ExpireDate
      ReturnURL
      NotifyURL
      CustomerURL
      ClientBackURL
      EmailModify
      LoginType
      CREDIT
      ANDROIDPAY
      SAMSUNGPAY
      LINEPAY
      ImageUrl
      InstFlag
      CreditRed
      UNIONPAY
      WEBATM
      VACC
      BankType
      CVS
      BARCODE
      ESUNWALLET
      TAIWANPAY
      CVSCOM
      EZPAY
      EZPWECHAT
      EZPALIPAY
      LgsType
    ].freeze

    MAPPING_TABLE = {
      MerchantID: 'merchant_id',
      HashKey: 'hash_key',
      HashIV: 'hash_iv',
      RespondType: 'respond_type',
      Version: 'version',
      LangType: 'lang_type',
      TradeLimit: 'trade_limit',
      ExpireDate: 'expire_date',
      ReturnURL: 'return_url',
      NotifyURL: 'notify_url',
      CustomerURL: 'customer_url',
      ClientBackURL: 'client_back_url',
      EmailModify: 'email_modify',
      LoginType: 'login_type',
      CREDIT: 'credit',
      ANDROIDPAY: 'android_pay',
      SAMSUNGPAY: 'samsung_pay',
      LINEPAY: 'line_pay',
      ImageUrl: 'image_url',
      InstFlag: 'inst_flag',
      CreditRed: 'credit_red',
      UNIONPAY: 'union_pay',
      WEBATM: 'web_atm',
      VACC: 'vacc',
      BankType: 'bank_type',
      CVS: 'cvs',
      BARCODE: 'bar_code',
      ESUNWALLET: 'esun_wallet',
      TAIWANPAY: 'taiwan_pay',
      CVSCOM: 'cvscom',
      EZPAY: 'ez_pay',
      EZPWECHAT: 'ezp_wechat',
      EZPALIPAY: 'ezp_ali_pay',
      LgsType: 'lgs_type'
    }.freeze

    self.options = {}.with_indifferent_access

    OPTIONS.each do |option|
      transfer_option = MAPPING_TABLE[:"#{option}"]
      define_method("#{transfer_option}=") do |value|
        options[option] = value
      end
    end

    def configure
      yield self
    end
  end
end
