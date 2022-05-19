require 'spec_helper'

RSpec.describe Iterable::PushTemplates, :vcr do
  describe 'get' do
    let(:template_id) { 256_072 }
    let(:res) { subject.get template_id }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns template' do
        expect(res.body['templateId']).to eq(template_id)
        expect(res.body['clientTemplateId']).to eq('5')
      end
    end

    context 'with non existing client id' do
      let(:template_id) { 42 }

      it 'responds as unsuccessful' do
        expect(res).not_to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns bad params' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to eq('BadParams')
      end
    end
  end

  describe 'update' do
    let(:template_id) { 256_072 }
    let(:new_template_message) { 'Pushing Pushes' }
    let(:update_attrs) do
      {
        message: new_template_message
      }
    end
    let(:res) { subject.update template_id, update_attrs }

    context 'when successful' do
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

    context 'with non existing client id' do
      let(:template_id) { 42 }

      it 'responds as unsuccessful' do
        expect(res).not_to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns bad params' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to eq('BadParams')
      end
    end
  end

  describe 'upsert' do
    let(:client_template_id) { '5' }
    let(:upsert_attrs) do
      {
        message: 'Sample example push'
      }
    end
    let(:res) { subject.upsert client_template_id, upsert_attrs }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
        expect(res.body['msg']).to match(/upserted \d+ templates/i)
      end
    end
  end
end
