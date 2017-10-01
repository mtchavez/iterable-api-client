require 'spec_helper'

RSpec.describe Iterable::Lists, :vcr do
  let(:resp_body) { res.body }

  describe 'all' do
    let(:res) { subject.all }
    let(:lists) { resp_body['lists'] }

    context 'successfully' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns lists' do
        expect(lists).to be_a(Array)
        expect(lists.size).to eq(5)
      end
    end
  end
end
