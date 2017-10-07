require 'spec_helper'

RSpec.describe Iterable::Email, :vcr do
  describe 'view' do
    let(:email) { 'user@example.com' }
    let(:message_id) { '975dc1f8917643bda9312b0d22a8f152' }
    let(:res) { subject.view email, message_id }

    context 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns html for email' do
        expect(res.body).to start_with('<html><head><title>')
      end
    end

    context 'wrong email' do
      let(:email) { 'marge@example.com' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end
