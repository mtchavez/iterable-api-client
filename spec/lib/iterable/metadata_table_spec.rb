require 'spec_helper'

RSpec.describe Iterable::MetadataTable, :vcr do
  let(:name) { 'exampletable' }
  subject { described_class.new name }

  describe 'add' do
    let(:key) { 'foo' }
    let(:value) { { bar: 'bling' } }
    let(:res) { subject.add key, value }

    describe 'successful' do
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

    context 'without value' do
      let(:value) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end
