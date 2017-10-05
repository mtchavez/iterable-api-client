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

  describe 'for_email' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:res) { subject.for_email email }
    let(:user) { res.body['user'] }

    describe 'successful' do
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

    describe 'not found' do
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

  describe 'for_id' do
    let(:email) { 'sample-1507173084@example.com' }
    let(:user_id) { '1' }
    let(:res) { subject.for_id user_id }
    let(:user) { res.body['user'] }

    describe 'successful' do
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

    describe 'not found' do
      let(:user_id) { '42' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end