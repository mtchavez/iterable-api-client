require 'openssl'
require 'uri'

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

    def get(headers = {})
      execute :get, {}, headers
    end

    def post(body = {}, headers = {})
      execute :post, body, headers
    end

    def put(body = {}, headers = {})
      execute :put, body, headers
    end

    def patch(body = {}, headers = {})
      execute :patch, body, headers
    end

    def delete(body = {}, headers = {})
      execute :delete, body, headers
    end

    private def execute(verb, body = {}, headers = {})
      http = connection(verb, body, headers)
      setup_http(http)
      transmit http
    end

    private def connection(verb, body = {}, headers = {})
      conn_headers = DEFAULT_HEADERS.merge(headers).merge('Api-Key' => @config.token)
      req = Net::HTTP.const_get(verb.to_s.capitalize, false).new(@uri, conn_headers)
      req.body = JSON.dump(body)
      req
    end

    private def setup_http(http)
      DEFAULT_OPTIONS.dup.each do |option, value|
        setter = "#{option.to_sym}="
        http.send(setter, value) if http.respond_to?(setter)
      end
    end

    private def build_uri(path, params = {})
      uri = @config.uri
      uri.path += path
      uri.query = URI.encode_www_form(params) unless params.empty?
      uri
    end

    private def net_http
      Net::HTTP.new(@uri.hostname, @uri.port, nil, nil, nil, nil)
    end

    private def transmit(req)
      response = nil
      @net.start do |http|
        response = http.request(req, nil, &:read_body)
      end
      handle_response response
    end

    private def handle_response(response)
      redirected = response.is_a?(Net::HTTPRedirection) || response.code == '303'
      if redirected && response['location']
        Response.new Net::HTTP.get_response(uri_for_redirect(response))
      else
        Response.new response
      end
    end

    private def uri_for_redirect(response)
      uri = @config.uri
      redirect_uri = URI(response['location'])
      uri.path = redirect_uri.path
      uri.query = redirect_uri.query
      uri
    end
  end
end
