# frozen_string_literal: true

RSpec.describe Newebpay::Refund, type: :model do
  context "when didn't pass required argument" do
    it 'raise error' do
      expect { Newebpay::Refund.new }.to raise_error Newebpay::PaymentArgumentError
    end
  end

  describe '#request!' do
    it 'send form data to request refund' do
      VCR.use_cassette('refund_request') do
        refunder = Newebpay::Refund.new(order_number: 'e5orkziyyte5', amount: 100)
        expect(refunder.request!).to eq({ Message: '退款資料新增成功_模擬信用卡退款成功',
                                          Result: { Amt: 100, MerchantID: 'MS136041943', MerchantOrderNo: 'e5orkziyyte5', TradeNo: '22070316284516819' }.stringify_keys, Status: 'SUCCESS' }.stringify_keys)
      end
    end
  end

  describe '#success?' do
    context 'when success' do
      it 'return true' do
        VCR.use_cassette('refund_request') do
          refunder = Newebpay::Refund.new(order_number: 'e5orkziyyte5', amount: 100)
          refunder.request!
          expect(refunder.success?).to eq true
        end
      end
    end

    context 'when failed' do
      it 'return false' do
        VCR.use_cassette('refund_request_failed') do
          refunder = Newebpay::Refund.new(order_number: 'e5orkziyyte6', amount: 100)
          refunder.request!
          expect(refunder.success?).to eq false
        end
      end
    end
  end

  describe '#refund_info' do
    it 'return refund information' do
      Timecop.freeze(Time.local(2022))
      refunder = Newebpay::Refund.new(order_number: 'e5orkziyyte6', amount: 100)
      expect(refunder.refund_info).to eq({ Amt: 100, CloseType: 2, IndexType: 1, MerchantOrderNo: 'e5orkziyyte6',
                                           RespondType: 'JSON', TimeStamp: '1640966400', Version: '1.1' })
    end
  end

  describe '#response' do
    context 'when has response' do
      it 'return refund response' do
        VCR.use_cassette('refund_request') do
          refunder = Newebpay::Refund.new(order_number: 'e5orkziyyte5', amount: 100)
          refunder.request!
          expect(refunder.response).to eq({ Message: '退款資料新增成功_模擬信用卡退款成功',
                                            Result: { Amt: 100, MerchantID: 'MS136041943', MerchantOrderNo: 'e5orkziyyte5', TradeNo: '22070316284516819' }.stringify_keys, Status: 'SUCCESS' }.stringify_keys)
        end
      end
    end

    context 'when did not has response' do
      it 'return nil' do
        refunder = Newebpay::Refund.new(order_number: 'e5orkziyyte5', amount: 100)
        expect(refunder.response).to be_nil
      end
    end
  end
end
