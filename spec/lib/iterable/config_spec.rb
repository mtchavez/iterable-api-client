# typed: false

require 'spec_helper'

RSpec.describe Iterable::Config do
  subject(:conf) { described_class.new token: test_token }

  let(:test_token) { 'asdf123' }

  describe 'initialize' do
    it 'sets default host' do
      expect(conf.host).to eql(described_class::DEFAULT_HOST)
    end

    it 'sets default version' do
      expect(conf.version).to eql(described_class::DEFAULT_VERSION)
    end

    it 'sets default port' do
      expect(conf.port).to eql(described_class::DEFAULT_PORT)
    end

    it 'defaults token to nil' do
      expect(described_class.new.token).to be_nil
    end

    context 'with a token' do
      it 'sets the token' do
        expect(conf.port).to eql(described_class::DEFAULT_PORT)
      end
    end
  end
end
