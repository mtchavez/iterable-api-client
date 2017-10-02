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
end
