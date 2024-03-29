# typed: false

require 'spec_helper'

RSpec.describe Iterable do
  it 'is a module' do
    expect(described_class).to be_a(Module)
  end

  describe 'configuration' do
    before do
      described_class.configure do |config|
        config.token = 'test-key'
      end
    end

    it 'takes block to set config' do
      expect(described_class.config.token).to eql 'test-key'
    end

    it 'token can be updated after being configured' do
      described_class.config.token = 'new-key'
      expect(described_class.config.token).to eql 'new-key'
    end
  end
end
