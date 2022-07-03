# frozen_string_literal: true

RSpec.describe Newebpay::SHA256::Cryptographic, type: :model do
  describe '#encrypt' do
    it 'return encrypt string' do
      encrypted_data = Newebpay::SHA256::Cryptographic.new('f03165cfdf3921768ea2ccde02d5998b2af064561171f33abeb48cd48474c92d5c9e702dea50b69f4ecc2cb99c1ebc1678fc761050a7bb9688a6591497beda3d2764a74f869d838e991e640ffee77101255b43457ae581b2632b8a9acd01e4ad').encrypt
      expect(encrypted_data).to eq 'CBAB8A44EB506F7D6FB24C0E767B176F9A7022E5F69F7E8A93C9C7BF42F41F13'
    end
  end
end
