require 'spec_helper'

RSpec.describe Iterable::Users, :vcr do
  describe 'update' do
    let(:email) { "sample-#{Time.now.to_i}@example.com" }
    let(:res) { subject.update email }

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

    describe 'without email' do
      let(:email) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end
