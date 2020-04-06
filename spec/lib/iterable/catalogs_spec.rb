require 'spec_helper'

RSpec.describe Iterable::Catalogs, vcr: :none do
  let(:config) { Iterable.config }
  let(:catalog_name) { 'test-catalog' }
  let(:catalog) { described_class.new(catalog_name) }
  let(:test_request) { instance_double(Iterable::Request) }

  describe 'create' do
    let(:api_url) { "/catalogs/#{catalog_name}" }

    subject(:create) { catalog.create }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:post)
      create
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:post)
    end
  end

  describe 'delete' do
    let(:api_url) { "/catalogs/#{catalog_name}" }

    subject(:delete) { catalog.delete }

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

  describe 'names' do
    let(:api_url) { '/catalogs' }

    subject(:names) { catalog.names(params) }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:get)
      names
    end

    context 'without params' do
      let(:params) { {} }

      it 'calls correct endpoint', :aggregate_errors do
        expect(Iterable).to have_received(:request).with(config, api_url, params)
        expect(test_request).to have_received(:get)
      end
    end

    context 'with params' do
      let(:params) { { page: 1, pageSize: 10 } }

      it 'calls correct endpoint', :aggregate_errors do
        expect(Iterable).to have_received(:request).with(config, api_url, params)
        expect(test_request).to have_received(:get)
      end
    end
  end
end
