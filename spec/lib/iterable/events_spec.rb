require 'spec_helper'

RSpec.describe Iterable::Events, :vcr do
  describe 'for_email' do
    let(:email) { 'user@example.com' }
    let(:res) { subject.for_email email }
    let(:events) { res.body['events'] }

    context 'successfully' do
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
    let(:name) { "event-#{Time.now}" }
    let(:email) { 'user@example.com' }
    let(:res) { subject.track name, email }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns events' do
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
end
