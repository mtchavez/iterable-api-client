require 'spec_helper'

RSpec.describe Iterable::Channels, :vcr do
  describe 'all' do
    let(:res) { subject.all }
    let(:channels) { res.body['channels'] }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns channels' do
        expect(channels).to be_a(Array)
        expect(channels.size).to eq(3)
      end
    end
  end
end
