# frozen_string_literal: true

RSpec.describe Newebpay::Invoice, type: :model do
  context "when didn't pass required argument" do
    it 'raise error' do
      expect { Newebpay::Invoice.new }.to raise_error Newebpay::PaymentArgumentError
    end
  end

  describe '#request!' do
    it 'send form data to request refund' do
      VCR.use_cassette('invoice_request') do
        invoicer = Newebpay::Invoice.new(order_number: 'xgruotokea5y', amount: 1234)
        expect(invoicer.request!).to eq({ Message: '請款資料新增成功_模擬信用卡請款成功',
                                          Result: { Amt: 1234, MerchantID: 'MS136041943', MerchantOrderNo: 'xgruotokea5y', TradeNo: '22070412073408373' }.stringify_keys, Status: 'SUCCESS' }.stringify_keys)
      end
    end
  end

  describe '#success?' do
    context 'when success' do
      it 'return true' do
        VCR.use_cassette('invoice_request') do
          invoicer = Newebpay::Invoice.new(order_number: 'xgruotokea5y', amount: 1234)
          invoicer.request!
          expect(invoicer.success?).to eq true
        end
      end
    end

    context 'when failed' do
      it 'return false' do
        VCR.use_cassette('invoice_request_failed') do
          invoicer = Newebpay::Invoice.new(order_number: 'xgruotokea5y', amount: 1234)
          invoicer.request!
          expect(invoicer.success?).to eq false
        end
      end
    end
  end

  describe '#invoice_info' do
    it 'return invoice information' do
      invoicer = Newebpay::Invoice.new(order_number: 'xgruotokea5y', amount: 1234)
      expect(invoicer.invoice_info).to eq({ Amt: 1234, CloseType: 1, IndexType: 1, MerchantOrderNo: 'xgruotokea5y',
                                           RespondType: 'JSON', TimeStamp: '1656933780', Version: '1.1' })
    end
  end

  describe '#response' do
    context 'when has response' do
      it 'return refund response' do
        VCR.use_cassette('invoice_request') do
          invoicer = Newebpay::Invoice.new(order_number: 'xgruotokea5y', amount: 1234)
          invoicer.request!
          expect(invoicer.response).to eq({ Message: '請款資料新增成功_模擬信用卡請款成功',
                                            Result: { Amt: 1234, MerchantID: 'MS136041943', MerchantOrderNo: 'xgruotokea5y', TradeNo: '22070412073408373' }.stringify_keys, Status: 'SUCCESS' }.stringify_keys)
        end
      end
    end

    context 'when did not has response' do
      it 'return nil' do
        invoicer = Newebpay::Invoice.new(order_number: 'xgruotokea5y', amount: 1234)
        expect(invoicer.response).to be_nil
      end
    end
  end
end
