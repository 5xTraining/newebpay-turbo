# frozen_string_literal: true

RSpec.describe Newebpay::Response, type: :model do
  context "when didn't pass argument" do
    it 'raise error' do
      expect { Newebpay::Response.new }.to raise_error(ArgumentError)
    end
  end

  describe '#success?' do
    context 'when success' do
      it 'return true' do
        response = instance_double(Newebpay::Response)
        allow(response).to receive(:success?).and_return true
        expect(response.success?).to eq true
      end
    end

    context 'when false' do
      it 'return true' do
        response = instance_double(Newebpay::Response)
        allow(response).to receive(:success?).and_return false
        expect(response.success?).to eq false
      end
    end
  end
end
