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

  describe 'create' do
    let(:name) { "list-#{Time.now.to_i}" }
    let(:template_id) { 231_155 }
    let(:list_ids) { [58_508] }
    let(:res) { subject.create name, template_id, list_ids }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns campaignId' do
        expect(res.body['campaignId']).to be_a(Integer)
      end
    end

    context 'without required params' do
      let(:name) { '' }
      let(:template_id) { 42 }
      let(:list_ids) { [] }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end
  end
end
