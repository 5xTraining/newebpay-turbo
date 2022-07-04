# frozen_string_literal: true

Newebpay.configure do |config|
  # ====================
  # necessary parameters
  # ====================

  # Puts your MerchantID/HashKey/HashIV in environment variable
  config.merchantID = nil
  config.hashKey    = nil
  config.hashIV     = nil

  # Currently this gem only supports JSON format
  config.respondType = 'JSON'

  # Newebpay api version
  config.version = '2.0'

  # 0 = No login required for newebpay, 1 = Must login to newebpay
  config.loginType = 0

  # ====================
  # non-required parameters
  # ====================

  # The default language is zh-tw, you can also change it to en or jp
  # config.langType = ''

  # Accept integer format only, 0 means not enabled, maximum seconds is 900, minimum is 60
  # config.tradeLimit  = 0

  # Paydeadline, accept varchar format only, maximum accepted 180 days
  # config.expireDate = ''

  # The URL returned when payment is completed, method: :post
  # config.returnURL = ''

  # The URL ending payment information by asynchronous, method: :post
  # config.notifyURL = ''

  # The URL of the numbering system, method: :post
  # config.customerURL = ''

  # Return button URL on the newebpay page
  # config.clientBackURL = ''

  # Email open for modification or not, 0 means not enabled, 1 means enabled
  # config.emailModify = 0

  # Credit card lump sum, 0 means not enabled, 1 means enabled
  # config.cREDIT = 0

  # Android Pay, 0 means not enabled, 1 means enabled
  # config.aNDROIDPAY = 0

  # Samsung Pay, 0 means not enabled, 1 means enabled
  # config.sAMSUNGPAY = 0

  # LINEPAY, 0 means not enabled, 1 means enabled
  # config.lINEPAY  = 0

  # LINEPAY Product image URL, only accept varchar
  # config.imageUrl = ''

  # Credit card pay in installments, only accept varchar, 1 means open all options, 0 means not enabled, example: '3,6,12' means open 3 & 6 & 12 installments etc.
  # config.instFlag = '0'

  # Credit card bonus, 0 means not enabled, 1 means enabled
  # config.creditRed = 0

  # UNIONPAY, 0 means not enabled, 1 means enabled
  # config.uNIONPAY = 0

  # WEBATM, 0 means not enabled, 1 means enabled, maximum amount is 50,000 NTD
  # config.wEBATM = 0

  # Transfer money, 0 means not enabled, 1 means enabled, maximum amount is 50,000 NTD
  # config.vACC = 0

  # Financial institutions can be designated, example: 'BOT,Taishin' etc.
  # config.bankType = ''

  # Supermarket codes payment, 0 means not enabled, 1 means enabled, maximum amount is 20,000 NTD, minimum amount is 30 NTD
  # config.cVS = 0

  # Supermarket barcode payment, 0 means not enabled, 1 means enabled, maximum amount is 40,000 NTD, minimum amount is 20 NTD
  # config.bARCODE = 0

  # Esum Wallet, 0 means not enabled, 1 means enabled
  # config.eSUNWALLET = 0

  # Taiwan pay, 0 means not enabled, 1 means enabled
  # config.tAIWANPAY = 0

  # Logistics Activation, 1 means Pickup without payment, 2 means Pickup with payment, 3 means both
  # config.cVSCOM = 0

  # EZPay, 0 means not enabled, 1 means enabled
  # config.eZPAY = 0

  # EZWechat Pay, 0 means not enabled, 1 means enabled
  # config.eZPWECHAT = 0

  # EZPali Pay, 0 means not enabled, 1 means enabled
  # config.eZPALIPAY  = 0

  # Logistics Type, only accpet varchar, 'B2C' and 'C2C'
  # config.lgsType = ''
end
