require 'spec_helper'

RSpec.describe Iterable::JsonExporter, :vcr do
  subject { described_class.new data_type, only_fields }

  let(:data_type) { Iterable::Export::EMAIL_SEND_TYPE }
  let(:only_fields) { %w[createdAt campaignId] }

  describe 'export_range' do
    let(:range) { Iterable::Export::ALL }
    let(:res) { subject.export_range range }
    let(:data) { res.body.split("\n") }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns exported data' do
        expect(data.length).to eq(23)
        # NOTE: API is not filtering fields
        # metric = JSON.parse(data.first)
        # expect(metric.keys).to match_array(only_fields)
      end
    end
  end

  describe 'export' do
    let(:end_time) { Time.parse('2017-10-24 23:30:30 UTC') }
    let(:start_time) { end_time - (60 * 60 * 24 * 30) }
    let(:res) { subject.export start_time, end_time }
    let(:data) { res.body.split("\n") }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns exported data' do
        expect(data.length).to eq(23)
        # NOTE: API is not filtering fields
        # metric = JSON.parse(data.first)
        # expect(metric.keys).to match_array(only_fields)
      end
    end
  end
end
