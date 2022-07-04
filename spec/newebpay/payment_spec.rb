# frozen_string_literal: true

RSpec.describe Newebpay::Payment, type: :model do
  context "when didn't pass required argument" do
    it 'raise error' do
      expect { Newebpay::Payment.new }.to raise_error Newebpay::PaymentArgumentError
    end
  end

  describe '#required_parameters' do
    it 'return newebpay needed form data' do
      Timecop.freeze(Time.local(2022))
      payment = Newebpay::Payment.new(order_number: '20220703ABC', amount: 100)
      expect(payment.required_parameters).to include({ MerchantID: 'MS136041943',
                                                       TradeSha: '28EAEFFC5B31A58CC7B2B7685364154EBEE5812D0B3066D5DD0C02BC59F77E7B', Version: '2.0' })
    end
  end

  describe '#trade_info' do
    it 'return trade information with hash' do
      Timecop.freeze(Time.local(2022))
      payment = Newebpay::Payment.new(order_number: '20220703ABC', amount: 100)
      expect(payment.trade_info).to eq({ MerchantID: 'MS136041943', Version: '2.0', MerchantOrderNo: '20220703ABC',
                                         Amt: 100, ItemDesc: '產品說明', TimeStamp: '1640966400', OrderComment: '' })
    end
  end
end
