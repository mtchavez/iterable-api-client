# typed: false

require 'spec_helper'

RSpec.describe Iterable::Users, :vcr do
  describe 'update' do
    let(:email) { "sample-#{Time.now.to_i}@example.com" }
    let(:res) { subject.update email }

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

      it 'returns headers' do
        expect(res['Content-Type']).to eq('application/json; charset=utf-8')
      end
    end

    context 'without email' do
      let(:email) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'bulk_update' do
    let(:users) do
      [
        { email: 'sample@example.com' },
        { email: 'bad@' }
      ]
    end
    let(:res) { subject.bulk_update users }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns update details' do
        expect(res.body['successCount']).to eq(1)
        expect(res.body['failCount']).to eq(1)
        expect(res.body['invalidEmails']).to include('bad@')
      end
    end

    context 'without users' do
      let(:users) { [] }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to match(/InvalidEmailAddressError/i)
      end
    end
  end

  describe 'update_subscriptions' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:res) { subject.update_subscriptions email }

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

    context 'with invalid email' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to match(/InvalidEmailAddressError/i)
      end
    end
  end

  describe 'bulk_update_subscriptions' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:subscriptions) do
      [
        { email: email }
      ]
    end
    let(:res) { subject.bulk_update_subscriptions subscriptions }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'responds with update details' do
        expect(res.body['successCount']).to eq(1)
        expect(res.body['failCount']).to be_zero
        expect(res.body['invalidEmails']).to be_empty
      end
    end

    context 'with invalid email' do
      let(:email) { 'foo@' }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with update details' do
        expect(res.body['successCount']).to be_zero
        expect(res.body['failCount']).to eq(1)
        expect(res.body['invalidEmails']).to include(email)
      end
    end
  end

  describe 'for_email' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:res) { subject.for_email email }
    let(:user) { res.body['user'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns user fields' do
        expect(user).to have_key('dataFields')
        expect(user['email']).to eq(email)
      end
    end

    context 'when not found' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to eq('InvalidEmailAddressError')
      end
    end
  end

  describe 'update_email' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:new_email) { 'sample-1507173084@example.org' }
    let(:res) { subject.update_email email, new_email }

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

    context 'when not found' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to eq('InvalidEmailAddressError')
      end
    end
  end

  describe 'delete' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:res) { subject.delete email }

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

    context 'when not found' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to eq('InvalidEmailAddressError')
      end
    end
  end

  describe 'delete_by_id' do
    let(:user_id) { '1' }
    let(:res) { subject.delete_by_id user_id }

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

    context 'when not found' do
      let(:user_id) { '42' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to eq('BadParams')
      end
    end
  end

  describe 'for_id' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:user_id) { '1' }
    let(:res) { subject.for_id user_id }
    let(:user) { res.body['user'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns user fields' do
        expect(user).to have_key('dataFields')
        expect(user['email']).to eq(email)
        expect(user['userId']).to eq(user_id)
      end
    end

    context 'when not found' do
      let(:user_id) { '42' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'fields' do
    let(:res) { subject.fields }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns user fields' do
        expect(res.body['fields']).to be_a(Hash)
      end
    end
  end

  describe 'register_browser_token' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:token) { (1..10).to_a.join }
    let(:res) { subject.register_browser_token email, token }

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

    context 'without email or userId' do
      let(:email) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'disable_device' do
    let(:token) { (1..10).to_a.join }
    let(:res) { subject.disable_device token }

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

    context 'without token' do
      let(:token) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'sent_messages' do
    let(:email) { 'user@example.com' }
    let(:res) { subject.sent_messages email }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns messages' do
        expect(res.body['messages'].size).to eq(10)
      end
    end

    context 'without messages for email' do
      let(:email) { 'sample@example.com' }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns empty messages' do
        expect(res.body['messages']).to be_empty
      end
    end
  end

  describe 'forget' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:res) { subject.forget email }

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

    context 'with invalid email' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to match(/InvalidEmailAddressError/i)
      end
    end
  end
end
