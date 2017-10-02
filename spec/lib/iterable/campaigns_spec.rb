require 'spec_helper'

RSpec.describe Iterable::Campaigns, :vcr do
  let(:resp_body) { res.body }

  describe 'all' do
    let(:res) { subject.all }
    let(:campaigns) { resp_body['campaigns'] }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns campaigns' do
        expect(campaigns).to be_a(Array)
        expect(campaigns.size).to eq(35)
      end
    end
  end
end
