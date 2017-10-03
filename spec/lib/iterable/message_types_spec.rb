require 'spec_helper'

RSpec.describe Iterable::MessageTypes, :vcr do
  describe 'all' do
    let(:res) { subject.all }
    let(:message_types) { res.body['messageTypes'] }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns message types' do
        expect(message_types).to be_a(Array)
        expect(message_types.size).to eq(3)
      end
    end
  end
end
