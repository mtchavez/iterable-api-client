require 'spec_helper'
require 'csv'

RSpec.describe Iterable::Campaigns, :vcr do
  let(:resp_body) { res.body }

  describe 'all' do
    let(:res) { subject.all }
    let(:campaigns) { resp_body['campaigns'] }

    context 'when successful' do
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

    context 'when successful' do
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

  describe 'recurring' do
    let(:campaign_id) { 181_029 }
    let(:res) { subject.recurring campaign_id }
    let(:campaigns) { resp_body['campaigns'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns campaigns' do
        expect(campaigns).to be_a(Array)
        expect(campaigns.size).to be_zero
      end
    end

    context 'with non-recurring campaign id' do
      let(:campaign_id) { 181_030 }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error message' do
        expect(res.body['msg']).to match(/not a recurring campaign/i)
      end
    end
  end

  describe 'metrics' do
    let(:campaign_ids) { [176_828, 163_898] }
    let(:start_time) { nil }
    let(:end_time) { nil }
    let(:res) { subject.metrics campaign_ids, start_time, end_time }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns a metrics in CSV format' do
        expect { CSV.parse(res.body) }.not_to raise_error
        expect(res.body).to match(/#{campaign_ids.first}/)
        expect(res.body).to match(/#{campaign_ids.last}/)
      end

      describe 'with start/end times' do
        let(:start_time) { Date.parse '2017-09-01' }
        let(:end_time) { Date.parse '2017-09-30' }

        it 'responds with success' do
          expect(res).to be_success
        end

        it 'responds with response object' do
          expect(res).to be_a(Iterable::Response)
        end

        it 'returns a metrics in CSV format' do
          expect { CSV.parse(res.body) }.not_to raise_error
          expect(res.body).to match(/#{campaign_ids.first}/)
          expect(res.body).to match(/#{campaign_ids.last}/)
        end
      end
    end

    context 'without required params' do
      let(:campaign_ids) { [] }

      it 'is successful' do
        expect(res).to be_success
      end

      it 'returns empty CSV' do
        expect { CSV.parse(res.body) }.not_to raise_error
        expect(res.body).to match(/id,/)
      end
    end
  end
end
