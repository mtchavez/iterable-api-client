require 'spec_helper'

RSpec.describe Iterable::Workflows, :vcr do
  describe 'trigger' do
    let(:workflow_id) { 14_898 }
    let(:list_id) { 58_508 }
    let(:attrs) do
      {
        listId: list_id
      }
    end
    let(:res) { subject.trigger workflow_id, attrs }

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

    describe 'without listId or email' do
      let(:attrs) { {} }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['msg']).to match(/Must provide either an email or list id/i)
        expect(res.body['code']).to match(/GenericError/i)
      end
    end
  end
end
