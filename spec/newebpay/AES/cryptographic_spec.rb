# frozen_string_literal: true

RSpec.describe Newebpay::AES::Cryptographic, type: :model do
  let!(:original_data) { "MerchantID=MS136041943&TimeStamp=1656845471&Version=2.0&MerchantOrderNo=123&Amt=100" }

  describe '#encrypt' do
    it 'return encrypt string' do
      encrypted_data = Newebpay::AES::Cryptographic.new(original_data).encrypt
      expect(encrypted_data).to eq 'f03165cfdf3921768ea2ccde02d5998b2af064561171f33abeb48cd48474c92d5c9e702dea50b69f4ecc2cb99c1ebc1678fc761050a7bb9688a6591497beda3d2764a74f869d838e991e640ffee77101255b43457ae581b2632b8a9acd01e4ad'
    end
  end

  describe '#decrypt' do
    it 'return original data' do
      decrypt_data = Newebpay::AES::Cryptographic.new("f03165cfdf3921768ea2ccde02d5998b2af064561171f33abeb48cd48474c92d5c9e702dea50b69f4ecc2cb99c1ebc1678fc761050a7bb9688a6591497beda3d2764a74f869d838e991e640ffee77101255b43457ae581b2632b8a9acd01e4ad").decrypt
      expect(decrypt_data).to eq original_data
    end
  end
end
