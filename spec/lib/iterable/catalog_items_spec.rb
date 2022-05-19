require 'spec_helper'

RSpec.describe Iterable::CatalogItems, vcr: :none do
  let(:config) { Iterable.config }
  let(:catalog_name) { 'test-catalog' }
  let(:item_id) { 'asdf-1234-qwer-5678' }
  let(:catalog_items) { described_class.new(catalog_name, item_id) }
  let(:test_request) { instance_double(Iterable::Request) }

  describe 'all' do
    subject(:create) { catalog_items.all(params) }

    let(:api_url) { "/catalogs/#{catalog_name}/items" }
    let(:catalog_items) { described_class.new(catalog_name) }
    let(:params) { { page: 1, pageSize: 20 } }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:get)
      create
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url, params)
      expect(test_request).to have_received(:get)
    end
  end

  describe 'create' do
    subject(:create) { catalog_items.create(item_attributes) }

    let(:api_url) { "/catalogs/#{catalog_name}/items/#{item_id}" }
    let(:item_attributes) { { foo: 'bar', angle: 90 } }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:put)
    end

    it 'calls correct endpoint', :aggregate_errors do
      create
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:put).with(value: item_attributes)
    end

    context 'with replace alias' do
      it 'calls correct endpoint', :aggregate_errors do
        catalog_items.replace(item_attributes)
        expect(Iterable).to have_received(:request).with(config, api_url)
        expect(test_request).to have_received(:put).with(value: item_attributes)
      end
    end
  end

  describe 'update' do
    subject(:update) { catalog_items.update(item_attributes) }

    let(:api_url) { "/catalogs/#{catalog_name}/items/#{item_id}" }
    let(:item_attributes) { { foo: 'bar', angle: 90 } }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:patch)
      update
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:patch).with(update: item_attributes)
    end
  end

  describe 'get' do
    subject(:get) { catalog_items.get }

    let(:api_url) { "/catalogs/#{catalog_name}/items/#{item_id}" }

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

  describe 'delete' do
    subject(:delete) { catalog_items.delete }

    let(:api_url) { "/catalogs/#{catalog_name}/items/#{item_id}" }

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
