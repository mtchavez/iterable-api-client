require 'spec_helper'

RSpec.describe Iterable::Export, :vcr do
  # Test subclass of an export
  class TestSubclass < Iterable::Export
    def format
      'testing'
    end
  end

  let(:data_type) { described_class::EMAIL_OPEN_TYPE }
  let(:test_class) { TestSubclass.new data_type }

  subject { described_class.new data_type }

  describe 'format' do
    context 'when not provided' do
      # Subclass of an export without a format provided
      class NoFormat < Iterable::Export; end

      let(:test_class) { NoFormat.new data_type }

      it 'raises must implement error' do
        expect { subject.format }.to raise_error('#format must be implemented in child class')
      end
    end

    context 'when provided' do
      it 'returns format of class' do
        expect(test_class.format).to eq('testing')
      end
    end
  end
end
