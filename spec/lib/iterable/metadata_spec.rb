require 'spec_helper'

RSpec.describe Iterable::Metadata, :vcr do
  describe 'get' do
    let(:res) { subject.get }

    context 'without metadata' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns empty results' do
        expect(res.body['results']).to be_empty
      end
    end
  end
end
