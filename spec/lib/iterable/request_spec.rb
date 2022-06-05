require 'spec_helper'

RSpec.describe Iterable::Request do
  subject(:request) { described_class.new(config, path) }

  let(:test_token) { 'asdf-1234-qwer-5678' }
  let(:config) { Iterable::Config.new(token: test_token) }
  let(:test_net_http) { instance_double(Net::HTTP) }
  let(:test_request) { instance_double(Net::HTTP::Get) }
  let(:test_response) { instance_double(Iterable::Response) }
  let(:path) { '/test-path' }
  let(:test_uri) { URI("https://api.iterable.com/api#{path}") }
  let(:request_headers) { described_class::DEFAULT_HEADERS.merge('Api-Key' => test_token) }

  before do
    allow(Net::HTTP).to receive(:new).and_return(test_net_http)
    allow(net_http_class).to receive(:new).and_return(test_request)
    allow(test_net_http).to receive(:start).and_yield(test_net_http)
    allow(test_request).to receive(:body=)
    allow(test_net_http).to receive(:request).and_return(test_response)
    allow(test_response).to receive(:code)
    allow(test_response).to receive(:body)
  end

  describe 'get' do
    let(:net_http_class) { Net::HTTP::Get }
    let(:http_verb) { :get }

    before { request.get }

    it 'calls http request correctly', :aggregate_failures do
      expect(Net::HTTP).to have_received(:new).with(config.uri.hostname, config.uri.port, nil, nil, nil, nil)
      expect(net_http_class).to have_received(:new).with(test_uri, request_headers)
      expect(test_net_http).to have_received(:request).with(test_request, nil, &:read_body)
    end
  end

  describe 'post' do
    let(:net_http_class) { Net::HTTP::Post }
    let(:http_verb) { :post }

    before { request.post }

    it 'calls http request correctly', :aggregate_failures do
      expect(Net::HTTP).to have_received(:new).with(config.uri.hostname, config.uri.port, nil, nil, nil, nil)
      expect(net_http_class).to have_received(:new).with(test_uri, request_headers)
      expect(test_net_http).to have_received(:request).with(test_request, nil, &:read_body)
    end
  end

  describe 'put' do
    let(:net_http_class) { Net::HTTP::Put }
    let(:http_verb) { :put }

    before { request.put }

    it 'calls http request correctly', :aggregate_failures do
      expect(Net::HTTP).to have_received(:new).with(config.uri.hostname, config.uri.port, nil, nil, nil, nil)
      expect(net_http_class).to have_received(:new).with(test_uri, request_headers)
      expect(test_net_http).to have_received(:request).with(test_request, nil, &:read_body)
    end
  end

  describe 'patch' do
    let(:net_http_class) { Net::HTTP::Patch }
    let(:http_verb) { :patch }

    before { request.patch }

    it 'calls http request correctly', :aggregate_failures do
      expect(Net::HTTP).to have_received(:new).with(config.uri.hostname, config.uri.port, nil, nil, nil, nil)
      expect(net_http_class).to have_received(:new).with(test_uri, request_headers)
      expect(test_net_http).to have_received(:request).with(test_request, nil, &:read_body)
    end
  end

  describe 'delete' do
    let(:net_http_class) { Net::HTTP::Delete }
    let(:http_verb) { :delete }

    before { request.delete }

    it 'calls http request correctly', :aggregate_failures do
      expect(Net::HTTP).to have_received(:new).with(config.uri.hostname, config.uri.port, nil, nil, nil, nil)
      expect(net_http_class).to have_received(:new).with(test_uri, request_headers)
      expect(test_net_http).to have_received(:request).with(test_request, nil, &:read_body)
    end
  end
end
