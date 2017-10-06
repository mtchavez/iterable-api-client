require 'spec_helper'

RSpec.describe Iterable::MetadataTable, :vcr do
  let(:name) { 'exampletable' }
  subject { described_class.new name }

  describe 'list_keys' do
    let(:res) { subject.list_keys }

    describe 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns keys for table' do
        results = res.body['results']
        expect(results.size).to eq(1)
        expect(results.first['table']).to eq(name)
      end
    end

    context 'non-existing table' do
      let(:name) { 'elbatelpmaxe' }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns empty results' do
        expect(res.body['results']).to be_empty
      end
    end
  end

  describe 'delete' do
    let(:res) { subject.delete }

    describe 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end

    context 'table not found' do
      let(:name) { 'dnuofton' }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end
  end

  describe 'add' do
    let(:key) { 'foo' }
    let(:value) { { bar: 'bling' } }
    let(:res) { subject.add key, value }

    describe 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end

    context 'without value' do
      let(:value) { nil }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error code' do
        expect(res.code).to eq('400')
      end
    end
  end

  describe 'get' do
    let(:key) { 'foo' }
    let(:res) { subject.get key }

    describe 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns key metadata' do
        expect(res.body['key']).to eq(key)
        expect(res.body['value']).to have_key('bar')
      end
    end

    context 'key not found' do
      let(:key) { 'dnuofton' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'returns error code' do
        expect(res.code).to eq('404')
      end
    end
  end

  describe 'remove' do
    let(:key) { 'foo' }
    let(:res) { subject.remove key }

    describe 'successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end

    context 'key not found' do
      let(:key) { 'dnuofton' }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end
  end
end
