module Iterable
  ##
  # Config provides a class to configre the API calls when interacting with
  # REST endpoints
  #
  # @example Creating a config object
  #   Iterable::Config.new token: 'secret-token'
  class Config
    DEFAULT_VERSION = '1.8'.freeze
    DEFAULT_HOST = 'https://api.iterable.com'.freeze
    DEFAULT_URI = "#{DEFAULT_HOST}/api".freeze
    DEFAULT_PORT = 443

    attr_accessor :token
    attr_reader :host, :port, :version

    ##
    #
    # initialize a new [Iterable::Config] object for requests
    #
    # @param token [String] Iterable API token
    # @return [Iterable::Config]
    def initialize(token: nil)
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
      @version = DEFAULT_VERSION
      @token = token
    end

    ##
    #
    # Creates a [URI] for the API host
    #
    # @return [URI] API URI object
    def uri
      URI.parse("#{@host || DEFAULT_HOST}:#{@port || DEFAULT_PORT}/api")
    end
  end
end
