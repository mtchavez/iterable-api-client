require 'spec_helper'
require 'securerandom'

RSpec.describe Iterable::Catalog, :vcr do
  let(:name) { 'example-catalog' }
  let(:catalog) { described_class.new(name) }

  describe 'field_mappings' do
    subject(:res) { catalog.field_mappings }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns defined mappings' do
        expect(res.body.dig('params', 'definedMappings')).to be_a Hash
      end

      it 'returns a list of undefined fields' do
        expect(res.body.dig('params', 'undefinedFields')).to be_a Array
      end
    end

    context 'non-existing catalog' do
      it 'fails with code 500' do
        expect(res.code).to eq '500'
      end
    end
  end

  describe 'update_field_mappings' do
    subject(:res) { catalog.update_field_mappings(mappings) }

    let(:mapping) { { fieldName: 'exampleString', fieldType: 'string' } }
    let(:mappings) { [mapping] }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'updates the field mappings' do
        res
        expect(catalog.field_mappings.body.dig('params', 'definedMappings', 'exampleString')).to eq 'string'
      end

      context 'with invalid params' do
        let(:mapping) { { something: 'wicked' } }

        it 'fails with code 400' do
          expect(res.code).to eq '400'
        end
      end
    end

    context 'non-existing catalog' do
      it 'fails with code 500' do
        expect(res.code).to eq '500'
      end
    end
  end

  describe 'delete' do
    subject(:res) { catalog.delete }

    context 'with an existing catalog' do
      before { catalog.create }

      it 'responds with success' do
        expect(res).to be_success
      end
    end

    context 'non-existing catalog' do
      it 'fails' do
        pending 'this currently returns 200'
        expect(res).not_to be_success
      end
    end
  end

  describe 'create' do
    subject(:res) { catalog.create }
    after { catalog.delete }

    it 'responds with success' do
      expect(res).to be_success
    end

    context 'creating a duplicate catalog' do
      before { catalog.create }

      it 'fails with code 400' do
        expect(res.code).to eq '400'
      end
    end
  end

  describe 'remove' do
    let(:key) { 123 }
    subject(:res) { catalog.remove(key) }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      context 'for an existing key' do
        before { catalog.update(key, foo: 'bar') }

        it 'responds with success' do
          expect(res).to be_success
        end
      end

      context 'for a non-existant key' do
        it 'responds with success' do
          expect(res).to be_success
        end
      end
    end

    context 'non-existing catalog' do
      it 'responds with success' do
        expect(res).to be_success
      end
    end
  end

  describe 'get' do
    let(:key) { 123 }
    subject(:res) { catalog.get(key) }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      context 'for an existing key' do
        before { catalog.update(key, foo: 'bar') }

        # updating is async, so we have to wait a long time when recording cassettes
        before { sleep 20 if ENV['RECORD_DELAY'] }

        it 'responds with success' do
          expect(res).to be_success
        end

        it 'returns the requested item' do
          expect(res.body.dig('params', 'value')).to eq('foo' => 'bar')
        end
      end

      context 'for a non-existant key' do
        it 'returns 404' do
          expect(res.code).to eq '404'
        end
      end
    end

    context 'non-existing catalog' do
      it 'returns 404' do
        expect(res.code).to eq '404'
      end
    end
  end

  describe 'update' do
    let(:key) { 123 }
    let(:update_value) { { orange: 'julius', lemon: 'wedge' } }
    subject(:res) { catalog.update(key, update_value) }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      context 'for an existing key' do
        before { catalog.replace(key, lime: 'juice', lemon: 'slice') }

        # updating is async, so we have to wait a long time when recording cassettes
        before { sleep 20 if ENV['RECORD_DELAY'] }

        it 'responds with success' do
          expect(res).to be_success
        end

        it 'adds new fields' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'orange')).to eq('julius')
        end

        it 'updates existing fields' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'lemon')).to eq('wedge')
        end

        it 'leaves unmodified fields alone' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'lime')).to eq('juice')
        end
      end

      context 'for a non-existant key' do
        it 'responds with success' do
          expect(res).to be_success
        end

        it 'creates the record' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'orange')).to eq('julius')
        end
      end
    end

    context 'non-existing catalog' do
      it 'fails with code 400' do
        expect(res.code).to eq '400'
      end
    end
  end

  describe 'replace' do
    let(:key) { 123 }
    let(:update_value) { { orange: 'julius', lemon: 'wedge' } }
    subject(:res) { catalog.replace(key, update_value) }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      context 'for an existing key' do
        before { catalog.replace(key, lime: 'juice', lemon: 'slice') }

        # updating is async, so we have to wait a long time when recording cassettes
        before { sleep 20 if ENV['RECORD_DELAY'] }

        it 'responds with success' do
          expect(res).to be_success
        end

        it 'adds new fields' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'orange')).to eq('julius')
        end

        it 'updates existing fields' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'lemon')).to eq('wedge')
        end

        it 'removes extra fields' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'lime')).to be_nil
        end
      end

      context 'for a non-existant key' do
        it 'responds with success' do
          expect(res).to be_success
        end

        it 'creates the record' do
          res
          sleep 20 if ENV['RECORD_DELAY']
          expect(catalog.get(key).body.dig('params', 'value', 'orange')).to eq('julius')
        end
      end
    end

    context 'non-existing catalog' do
      it 'fails with code 400' do
        expect(res.code).to eq '400'
      end
    end
  end

  describe 'bulk_remove' do
    let(:key) { 123 }
    subject(:res) { catalog.bulk_remove(key) }

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      context 'for an existing key' do
        before { catalog.update(key, foo: 'bar') }
        # updating is async, so we have to wait a long time when recording cassettes
        before { sleep 20 if ENV['RECORD_DELAY'] }

        it 'responds with success' do
          expect(res).to be_success
        end
      end

      context 'for a non-existant key' do
        it 'responds with success' do
          expect(res).to be_success
        end
      end
    end

    context 'non-existing catalog' do
      it 'responds with success' do
        expect(res).to be_success
      end
    end
  end

  describe 'items' do
    let(:key) { 123 }
    subject(:res) { catalog.items }

    context 'with an existing catalog' do
      before do
        catalog.create
        catalog.update_field_mappings(fieldName: 'number', fieldType: 'long')
        1.upto(30).each { |i| catalog.replace(i, number: i) }
      end

      # updating is async, so we have to wait a long time when recording cassettes
      before { sleep 20 if ENV['RECORD_DELAY'] }

      after { catalog.delete }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'returns the first page of items' do
        expect(res.body.dig('params', 'catalogItemsWithProperties').size).to eq 10
      end

      context 'with a page number' do
        subject(:res) { catalog.items(page: 2) }

        it 'returns the given page of items' do
          expect(res.body.dig('params', 'previousPageUrl')).to include 'page=1'
          expect(res.body.dig('params', 'nextPageUrl')).to include 'page=3'
        end
      end

      context 'with a page size' do
        subject(:res) { catalog.items(page_size: 5) }

        it 'returns the given number of items' do
          expect(res.body.dig('params', 'catalogItemsWithProperties').size).to eq 5
        end
      end

      context 'with a given order' do
        context 'and ascending sort' do
          subject(:res) { catalog.items(order: 'number', sort_ascending: true) }

          it 'sorts the items ascending' do
            expect(
              res.body.dig('params', 'catalogItemsWithProperties').map { |c| c.dig('value', 'number') }
            ).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
          end
        end

        context 'and non-ascending sort' do
          subject(:res) { catalog.items(order: 'number', sort_ascending: false) }

          it 'sorts the items descending' do
            expect(
              res.body.dig('params', 'catalogItemsWithProperties').map { |c| c.dig('value', 'number') }
            ).to eq [30, 29, 28, 27, 26, 25, 24, 23, 22, 21]
          end
        end
      end
    end

    context 'non-existing catalog' do
      it 'returns 404' do
        expect(res.code).to eq '404'
      end
    end
  end

  describe 'bulk_create' do
    let(:item1) { { orange: 'julius', lemon: 'wedge' } }
    let(:item2) { { orange: 'slice', lemon: 'head' } }
    let(:documents) { { 1 => item1, 2 => item2 } }
    let(:replace_uploaded_fields_only) { true }

    subject(:res) do
      catalog.bulk_create(
        documents: documents,
        replace_uploaded_fields_only: replace_uploaded_fields_only
      )
    end

    context 'with an existing catalog' do
      before { catalog.create }
      after { catalog.delete }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'creates the records' do
        res
        sleep 40 if ENV['RECORD_DELAY']

        expect(catalog.get(1).body.dig('params', 'value', 'orange')).to eq('julius')
        expect(catalog.get(2).body.dig('params', 'value', 'orange')).to eq('slice')
      end

      context 'with an existing record' do
        before { catalog.replace(1, lime: 'juice', lemon: 'slice') }

        # updating is async, so we have to wait a long time when recording cassettes
        before { sleep 20 if ENV['RECORD_DELAY'] }

        context 'when replacing only uploaded fields' do
          let(:replace_uploaded_fields_only) { true }

          it 'adds new fields' do
            res
            sleep 20 if ENV['RECORD_DELAY']
            expect(catalog.get(1).body.dig('params', 'value', 'orange')).to eq('julius')
          end

          it 'updates existing fields' do
            res
            sleep 20 if ENV['RECORD_DELAY']
            expect(catalog.get(1).body.dig('params', 'value', 'lemon')).to eq('wedge')
          end

          it 'leaves unmodified fields alone' do
            res
            sleep 20 if ENV['RECORD_DELAY']
            expect(catalog.get(1).body.dig('params', 'value', 'lime')).to eq('juice')
          end
        end

        context 'when replacing entire records fields' do
          let(:replace_uploaded_fields_only) { false }

          it 'adds new fields' do
            res
            sleep 20 if ENV['RECORD_DELAY']
            expect(catalog.get(1).body.dig('params', 'value', 'orange')).to eq('julius')
          end

          it 'updates existing fields' do
            res
            sleep 20 if ENV['RECORD_DELAY']
            expect(catalog.get(1).body.dig('params', 'value', 'lemon')).to eq('wedge')
          end

          it 'removes extra fields' do
            res
            sleep 20 if ENV['RECORD_DELAY']
            expect(catalog.get(1).body.dig('params', 'value', 'lime')).to be_nil
          end
        end
      end
    end

    context 'non-existing catalog' do
      it 'returns 404' do
        expect(res.code).to eq '404'
      end
    end
  end
end
