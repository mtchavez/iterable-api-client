require 'spec_helper'

RSpec.describe Iterable::CatalogFieldMappings, vcr: :none do
  let(:config) { Iterable.config }
  let(:catalog_name) { 'test-catalog' }
  let(:field_mappings) { described_class.new(catalog_name) }
  let(:test_request) { instance_double(Iterable::Request) }

  describe 'get' do
    subject(:get) { field_mappings.get }

    let(:api_url) { "/catalogs/#{catalog_name}/fieldMappings" }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:get)
      get
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:get)
    end
  end

  describe 'update' do
    let(:api_url) { "/catalogs/#{catalog_name}/fieldMappings" }
    let(:test_body) { { mappingsUpdates: updates } }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:put)
    end

    context 'without updates' do
      subject(:update) { field_mappings.update }

      let(:updates) { [] }

      before { update }

      it 'calls correct endpoint', :aggregate_errors do
        expect(Iterable).to have_received(:request).with(config, api_url)
        expect(test_request).to have_received(:put).with(test_body)
      end
    end

    context 'with updates' do
      subject(:update) { field_mappings.update(updates) }

      let(:updates) { [{ fieldName: 'test-field', fieldType: 'string' }] }

      before { update }

      it 'calls correct endpoint', :aggregate_errors do
        expect(Iterable).to have_received(:request).with(config, api_url)
        expect(test_request).to have_received(:put).with(test_body)
      end
    end
  end
end
