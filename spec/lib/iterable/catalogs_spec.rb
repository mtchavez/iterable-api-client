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

  describe 'field_mappings' do
    let(:api_url) { "/catalogs/#{catalog_name}/fieldMappings" }

    subject(:field_mappings) { catalog.field_mappings }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:get)
      field_mappings
    end

    it 'calls correct endpoint', :aggregate_errors do
      expect(Iterable).to have_received(:request).with(config, api_url)
      expect(test_request).to have_received(:get)
    end
  end

  describe 'update_field_mappings' do
    let(:api_url) { "/catalogs/#{catalog_name}/fieldMappings" }
    let(:test_body) { { mappingsUpdates: updates } }

    before do
      allow(Iterable).to receive(:request).and_return(test_request)
      allow(test_request).to receive(:put)
    end

    context 'without updates' do
      let(:updates) { [] }

      subject(:update_field_mappings) { catalog.update_field_mappings }

      before { update_field_mappings }

      it 'calls correct endpoint', :aggregate_errors do
        expect(Iterable).to have_received(:request).with(config, api_url)
        expect(test_request).to have_received(:put).with(test_body)
      end
    end

    context 'with updates' do
      let(:updates) { [{ fieldName: 'test-field', fieldType: 'string' }] }

      subject(:update_field_mappings) { catalog.update_field_mappings(updates) }

      before { update_field_mappings }

      it 'calls correct endpoint', :aggregate_errors do
        expect(Iterable).to have_received(:request).with(config, api_url)
        expect(test_request).to have_received(:put).with(test_body)
      end
    end
  end
end
