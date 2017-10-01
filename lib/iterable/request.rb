require 'openssl'

module Iterable
  # @!visibility private
  class Request
    DEFAULT_OPTIONS = {
      use_ssl: true,
      verify_ssl: true,
      verify_mode: OpenSSL::SSL::VERIFY_PEER
    }.freeze

    DEFAULT_HEADERS = {
      'accept' => 'application/json',
      'content-type' => 'application/json'
    }.freeze

    def initialize(config, path, params = {})
      @config = config
      @uri = build_uri(path, params)
      @net = net_http
      setup_http(@net)
    end

    def get
      execute :get
    end

    def post(body = {})
      execute :post, body
    end

    def delete
      execute :delete
    end

    private

    def execute(verb, body = {})
      http = connection(verb, body)
      setup_http(http)
      transmit http
    end

    def connection(verb, body = {})
      req = Net::HTTP.const_get(verb.to_s.capitalize, false).new(@uri, DEFAULT_HEADERS)
      req.body = JSON.dump(body)
      req
    end

    def setup_http(http)
      DEFAULT_OPTIONS.dup.each do |option, value|
        setter = "#{option.to_sym}="
        http.send(setter, value) if http.respond_to?(setter)
      end
    end

    def build_uri(path, params = {})
      uri = @config.uri
      uri.path += path
      params['api_key'] = @config.token
      uri.query = URI.encode_www_form(params)
      uri
    end

    def net_http
      Net::HTTP.new(@uri.hostname, @uri.port, nil, nil, nil, nil)
    end

    def transmit(req)
      response = nil
      @net.start do |http|
        response = http.request(req, nil, &:read_body)
      end
      Response.new response
    end
  end
end
