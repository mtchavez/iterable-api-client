# typed: false

require 'csv'
require 'spec_helper'

RSpec.describe Iterable::Experiments, :vcr do
  subject { described_class.new experiment_ids }

  let(:experiment_ids) { [12_041] }

  describe 'metrics' do
    let(:campaign_ids) { [176_828] }
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
        end
      end
    end

    context 'without params' do
      let(:experiment_ids) { [] }
      let(:campaign_ids) { [] }

      it 'is successful' do
        expect(res).to be_success
      end

      it 'returns empty CSV' do
        expect { CSV.parse(res.body) }.not_to raise_error
        expect(res.body).to match(/#{campaign_ids.first}/)
      end
    end
  end
end
