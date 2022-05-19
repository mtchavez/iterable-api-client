require 'spec_helper'

RSpec.describe Iterable::Lists, :vcr do
  let(:resp_body) { res.body }

  describe 'all' do
    let(:res) { subject.all }
    let(:lists) { resp_body['lists'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns lists' do
        expect(lists).to be_a(Array)
        expect(lists.size).to eq(5)
      end
    end
  end

  describe 'create' do
    let(:name) { "list-#{Time.now.to_i}" }
    let(:res) { subject.create name }
    let(:list) { resp_body }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns list' do
        expect(list).to be_a(Hash)
        expect(list['listId']).to be_a(Integer)
      end
    end

    context 'without name' do
      let(:name) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'delete' do
    let(:list_id) { '61933' }
    let(:res) { subject.delete list_id }
    let(:list) { resp_body }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(resp_body['code']).to match(/^success/i)
      end
    end

    context 'with invalid id' do
      let(:list_id) { '42' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'users' do
    let(:list_id) { '56545' }
    let(:res) { subject.users list_id }
    let(:users) { resp_body }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns user emails newline separated' do
        emails = resp_body.split("\n")
        expect(emails.size).to be > 0
      end
    end

    context 'with invalid id' do
      let(:list_id) { '42' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'subscribe' do
    let(:list_id) { 58_508 }
    let(:subscribers) do
      [
        { email: 'sample@example.com' }
      ]
    end
    let(:res) { subject.subscribe list_id, subscribers }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns subscribe details' do
        expect(res.body['successCount']).to eq(1)
        expect(res.body['failCount']).to be_zero
        expect(res.body['invalidEmails']).to be_empty
      end
    end

    context 'without subscribers' do
      let(:subscribers) { [] }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns subscribe details' do
        expect(res.body['successCount']).to be_zero
        expect(res.body['failCount']).to be_zero
        expect(res.body['invalidEmails']).to be_empty
      end
    end

    context 'with invalid emails' do
      let(:subscribers) do
        [
          { email: 'user@' }
        ]
      end

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns subscribe details' do
        expect(res.body['successCount']).to be_zero
        expect(res.body['failCount']).to eq(1)
        expect(res.body['invalidEmails']).to include('user@')
      end
    end
  end

  describe 'unsubscribe' do
    let(:list_id) { 58_508 }
    let(:subscribers) do
      [
        { email: 'sample@example.com' }
      ]
    end
    let(:res) { subject.unsubscribe list_id, subscribers }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns subscribe details' do
        expect(res.body['successCount']).to eq(1)
        expect(res.body['failCount']).to be_zero
        expect(res.body['invalidEmails']).to be_empty
      end
    end

    context 'without subscribers' do
      let(:subscribers) { [] }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns subscribe details' do
        expect(res.body['successCount']).to be_zero
        expect(res.body['failCount']).to be_zero
        expect(res.body['invalidEmails']).to be_empty
      end
    end

    context 'with invalid emails' do
      let(:subscribers) do
        [
          { email: 'user@' }
        ]
      end

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns subscribe details' do
        expect(res.body['successCount']).to be_zero
        expect(res.body['failCount']).to eq(1)
        expect(res.body['invalidEmails']).to include('user@')
      end
    end
  end
end
