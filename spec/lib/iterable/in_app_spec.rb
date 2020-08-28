require 'spec_helper'

RSpec.describe Iterable::InApp, :vcr do
  let(:resp_body) { res.body }

  describe 'messages_for_email' do
    let(:email) { 'user@example.com' }
    let(:res) { subject.messages_for_email(email) }
    let(:messages) { resp_body['inAppMessages'] }

    context 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns messages' do
        expect(messages).to be_a(Array)
        expect(messages.size).to eq(1)
      end
    end
  end

  describe 'messages_for_user_id' do
    let(:user_id) { 42 }
    let(:res) { subject.messages_for_user_id(user_id, platform: 'iOS') }
    let(:messages) { resp_body['inAppMessages'] }

    context 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns messages' do
        expect(messages).to be_a(Array)
        expect(messages.size).to eq(1)
      end
    end
  end
end
