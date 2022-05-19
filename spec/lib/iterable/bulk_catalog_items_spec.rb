require 'spec_helper'
require 'securerandom'

RSpec.describe Iterable::BulkCatalogItems, vcr: :none do
  let(:config) { Iterable.config }
  let(:catalog_name) { 'test-catalog' }
  let(:bulk_catalog_items) { described_class.new(catalog_name) }
  let(:test_request) { instance_double(Iterable::Request) }

  describe 'create' do
    subject(:create) { bulk_catalog_items.create(items) }

    let(:api_url) { "/catalogs/#{catalog_name}/items" }
    let(:items) { { '1234567' => { foo: 'bar', angle: 90 } } }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:post)
      create
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:post).with(documents: items, replaceUploadedFieldsOnly: false)
    end
  end

  describe 'delete' do
    subject(:delete) { bulk_catalog_items.delete }

    let(:api_url) { "/catalogs/#{catalog_name}/items" }
    let(:item_ids) { [SecureRandom.uuid, SecureRandom.uuid] }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:delete)
      delete
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:delete)
    end
  end
end
