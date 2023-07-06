require 'spec_helper'

RSpec.describe Iterable::Email, :vcr do
  describe 'view' do
    let(:email) { 'user@example.com' }
    let(:message_id) { '975dc1f8917643bda9312b0d22a8f152' }
    let(:attrs) { {} }
    let(:res) { subject.view email, message_id, attrs }

    context 'with email' do
      context 'when successful' do
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

      context 'with wrong email' do
        let(:email) { 'marge@example.com' }

        it 'is not successful' do
          expect(res).not_to be_success
        end

        it 'returns error code' do
          expect(res.code).to eq('400')
        end
      end
    end

    context 'with userId' do
      let(:email) { nil }
      let(:attrs) do
        { userId: '84097' }
      end

      context 'when successful' do
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

      context 'with wrong userId' do
        let(:attrs) do
          { userId: '12345' }
        end

        it 'is not successful' do
          expect(res).not_to be_success
        end

        it 'returns error code' do
          expect(res.code).to eq('400')
        end
      end
    end
  end

  describe 'target' do
    let(:email) { 'user@example.com' }
    let(:campaign_id) { 344_851 }
    let(:res) { subject.target email, campaign_id }

    context 'when bad campaign_id' do
      let(:campaign_id) { 42 }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error code' do
        expect(res.code).to eq('400')
      end
    end

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'returns msg' do
        expect(res.body['msg']).to match(/Campaign #{campaign_id} - Sent triggered message to: #{email}/)
      end
    end
  end
end
