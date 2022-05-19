require 'spec_helper'

RSpec.describe Iterable::Export, :vcr do
  # Test subclass of an export
  subject(:export) { described_class.new data_type }

  let(:test_subclass) do
    Class.new(Iterable::Export) do
      def format
        'testing'
      end
    end
  end

  let(:data_type) { described_class::EMAIL_OPEN_TYPE }
  let(:test_class) { test_subclass.new data_type }

  describe 'format' do
    context 'when not provided' do
      # Subclass of an export without a format provided
      let(:no_format) do
        Class.new(described_class)
      end

      let(:test_class) { no_format.new data_type }

      it 'raises must implement error' do
        expect { export.format }.to raise_error('#format must be implemented in child class')
      end
    end

    context 'when provided' do
      it 'returns format of class' do
        expect(test_class.format).to eq('testing')
      end
    end
  end
end
