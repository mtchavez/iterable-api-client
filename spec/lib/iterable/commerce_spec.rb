# typed: false

require 'spec_helper'
require 'securerandom'

RSpec.describe Iterable::Commerce, :vcr do
  describe 'track_purchase' do
    let(:total) { 100.00 }
    let(:commerce_item) do
      {
        id: SecureRandom.uuid,
        name: 'Sample Item',
        price: total,
        quantity: 1
      }
    end
    let(:items) { [commerce_item] }
    let(:user) do
      {
        userId: '1',
        email: 'sample@example.com'
      }
    end
    let(:res) { subject.track_purchase total, items, user }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end

    context 'without required params' do
      let(:total) { '' }
      let(:items) { [] }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'update_cart' do
    let(:commerce_item) do
      {
        id: SecureRandom.uuid,
        name: 'Sample Item',
        price: 100.0,
        quantity: 1
      }
    end
    let(:items) { [commerce_item] }
    let(:user) do
      {
        userId: '1',
        email: 'sample@example.com'
      }
    end
    let(:res) { subject.update_cart user, items }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end

    context 'without required params' do
      let(:user) { {} }
      let(:items) { [] }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end
