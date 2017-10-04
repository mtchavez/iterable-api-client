require 'spec_helper'

RSpec.describe Iterable::EmailTemplates, :vcr do
  describe 'get' do
    let(:template_id) { 194_014 }
    let(:res) { subject.get template_id }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns template' do
        expect(res.body['templateId']).to eq(template_id)
        expect(res.body).to have_key('metadata')
      end
    end

    context 'non existing client id' do
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
end
