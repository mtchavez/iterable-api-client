require 'spec_helper'

RSpec.describe Iterable::Device, :vcr do
  let(:token) { (1..10).to_a.join('') }
  let(:app) { 'devAPNS' }
  let(:platform) { Iterable::Device::APNS_SANDBOX }

  subject { described_class.new token, app, platform }

  describe 'register' do
    let(:email) { 'user@example.com' }
    let(:res) { subject.register email }

    context 'successfully' do
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

    context 'without email' do
      let(:email) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error message' do
        expect(res.body['code']).to match(/InvalidEmailAddressError/i)
      end
    end

    context 'without token' do
      let(:token) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error message' do
        expect(res.body['msg']).to match(/Unable to register token/i)
      end
    end
  end
end
