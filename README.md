# Newebpay-Turbo

Online payment processing for internet businesses by newebpay from Taiwan

- [環境需求](#環境需求)
- [安裝方式](#安裝方式)
- [基礎設定](#基礎設定)
- [使用方式](#使用方式)
  - [傳送參數](#傳送參數)
  - [接受參數](#接受參數)
- [退費使用方式](#退費使用方式)
- [Bug or PR](#bug-or-pr)
- [License](#license)

# 環境需求

- Ruby 2.6+

# 安裝方式

目前這個 Gem 只在 Rails 專案內支援，故安裝方式請放在 `Gemfile` 內

`gem 'newebpay-turbo', '~> 0.2.5'`

`bundle install`

`rails generate newebpay:install`

會在 `config/initializer` 內產生 `newebpay.rb`

# 基礎設定

閱讀藍新金流官方手冊，根據需要的參數打開註解！

下列為必填參數，不然會造成錯誤

```
config.merchantID = nil # 建議使用環境變數帶入
config.hashKey    = nil # 建議使用環境變數帶入
config.hashIV     = nil # 建議使用環境變數帶入
config.respondType = 'JSON'
config.version = '2.0'
config.loginType = 0
...
```

# 使用方式

## 傳送參數

```ruby
# controllers
payment = Newebpay::Payment.new(
          order_number: YOUR_ORDER_NUMBER (required),
          amount: YOUR_ORDER_AMOUNT (required),
          email: YOUR_ORDER_EMAIL (optional),
          product_description: YOUR_PRODUCT_DESCRIPTION (default_value: 產品說明),
          order_comment: YOUR_ORDER_COMMENT (optional))

@form_info = payment.required_parameters # { MERCHANT_ID:..., TradeInfo: ..., TradeSha: ..., Version: '2.0' }

# views
<%= form_with url: NEWEBPAY_MPG_URL, method: :post do |form| >
  <% @form_info.each do |key, value|>
    <%= form.hidden_field key, { value: value } >
  <% end %>
<% end %>
```

上述 `required_parameters` 所產生的物件藍新金流串接需要的參數，接著根據手冊需要放入 `Form` 內使用 `POST` 的方式送至藍新金流

要不要使用 `hidden_field` 取決於網站設計，這個 `Gem` 負責提供完整的加密參數，上述只是範例，可以隨意活用。

## 接受參數

若是有加入 `ReturnURL` 或是 `NotifyURL` 的使用者，會接受到藍新傳送回來的付款資訊 ( 無論成功與否 )

```ruby
response = Newebpay::Response.new(params)

response.result # 付款的詳細資訊
response.success? # 確認付款是否成功
response.message # 交易資訊的訊息
response.order_number # 您送出的訂單編號
response.trade_number # 與藍新方的交易編號
response.ip # 付款者的 ip 位置
response.card_number_first_six_code # 付款者的信用卡前六碼
response.card_number_last_four_code # 付款者的信用卡後四碼
response.escrow_bank # 款項的託管銀行
response.auth_bank # 交易的授權銀行
response.pay_way # 付款者的交易方式 ( 信用卡, ATM ... )
response.inst # 0 為無分期, 1 為有分期
response.inst_first_price # 信用卡分期第一期繳費金額
response.inst_each_price # 信用卡分期每期繳費金額
response.atm_pay_bank_code # ATM 繳費的銀行代碼
response.atm_payer_account_last_five_code # ATM 付款者的帳號後五碼
response.paid_at # 繳費時間
```

# 退費使用方式

```ruby
refund = Newebpay::Refund.new(
         order_number: YOUR_ORDER_NUMBER (required),
         amount: YOUR_ORDER_AMOUNT (required))

@form_info = refund.required_parameters # { MERCHANT_ID:..., TradeInfo: ..., TradeSha: ..., Version: '1.1' }

# views
<%= form_with url: NEWEBPAY_MPG_REFUND_URL, method: :post do |form| >
  <% @form_info.each do |key, value|>
    <%= form.hidden_field key, { value: value } >
  <% end %>
<% end %>
```

# Bug or PR

任何 Bug 回報和 PR 都歡迎在這邊開 issue 或是直接發 PR

https://github.com/5xTraining/newebpay-turbo

# License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)

