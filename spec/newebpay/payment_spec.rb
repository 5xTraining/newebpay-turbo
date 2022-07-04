# frozen_string_literal: true

RSpec.describe Newebpay::Payment, type: :model do
  context "when didn't pass required argument" do
    it 'raise error' do
      expect { Newebpay::Payment.new }.to raise_error Newebpay::PaymentArgumentError
    end
  end

  describe '#required_parameters' do
    it 'return newebpay needed form data' do
      payment = Newebpay::Payment.new(order_number: '20220703ABC', amount: 100)
      expect(payment.required_parameters).to include({ MerchantID: 'MS136041943',
                                                       TradeSha: '08E5C806FA136F7A7B03687E94DBFD4FAA0CB8034459EB2C3A1883771FF73DA1', Version: '2.0' })
    end
  end

  describe '#trade_info' do
    it 'return trade information with hash' do
      payment = Newebpay::Payment.new(order_number: '20220703ABC', amount: 100)
      expect(payment.trade_info).to eq({ MerchantID: 'MS136041943', Version: '2.0', MerchantOrderNo: '20220703ABC', Email: '',
                                         Amt: 100, ItemDesc: '產品說明', TimeStamp: '1656933780', OrderComment: '' }.stringify_keys)
    end
  end
end
