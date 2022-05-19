require 'spec_helper'

RSpec.describe Iterable::Templates, :vcr do
  describe 'all' do
    let(:res) { subject.all }
    let(:templates) { res.body['templates'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns templates' do
        expect(templates).to be_a(Array)
        expect(templates.size).to eq(16)
      end
    end

    context 'with type' do
      let(:type) { described_class::TRIGGERED_TYPE }
      let(:res) { subject.all templateType: type }

      describe 'none for type' do
        it 'responds with success' do
          expect(res).to be_success
        end

        it 'responds with response object' do
          expect(res).to be_a(Iterable::Response)
        end

        it 'returns templates' do
          expect(templates).to be_a(Array)
          expect(templates.size).to be_zero
        end
      end
    end
  end

  describe 'for_client_template_id' do
    let(:client_template_id) { 1 }
    let(:res) { subject.for_client_template_id client_template_id }
    let(:templates) { res.body['templates'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns templates' do
        expect(templates).to be_a(Array)
        expect(templates.size).to eq(1)
      end
    end

    context 'with non existing client id' do
      let(:client_template_id) { 42 }

      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns templates' do
        expect(templates).to be_a(Array)
        expect(templates.size).to be_zero
      end
    end
  end
end
