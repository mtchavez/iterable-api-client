require 'spec_helper'

RSpec.describe Iterable::Events, :vcr do
  describe 'for_email' do
    let(:email) { 'user@example.com' }
    let(:res) { subject.for_email email }
    let(:events) { res.body['events'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns events' do
        expect(events).to be_a(Array)
        expect(events.size).to eq(30)
      end
    end
  end

  describe 'track' do
    let(:name) { 'event-2017-10-02 20:26:23 -0700' }
    let(:email) { 'user@example.com' }
    let(:res) { subject.track name, email }

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

    context 'without a name' do
      let(:name) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'track_bulk' do
    let(:name) { 'event-2017-10-02 20:26:23 -0700' }
    let(:events) do
      [
        { email: 'user@example.com', eventName: name },
        { email: 'bad@', eventName: name }
      ]
    end
    let(:res) { subject.track_bulk events }

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

    context 'without a name' do
      let(:name) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end

    context 'without events' do
      let(:events) { [] }

      it 'responds with success' do
        expect(res).to be_success
      end
    end
  end

  describe 'track_push_open' do
    let(:campaign_id) { 181_028 }
    let(:message_id) { '7091' }
    let(:email) { 'user@example.com' }
    let(:res) { subject.track_push_open campaign_id, message_id, email }

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

    context 'without an email or user id' do
      let(:email) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end
