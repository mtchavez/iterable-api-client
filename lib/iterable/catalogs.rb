# typed: true

module Iterable
  ##
  #
  # Interact with /catalogs/{catalogName} API endpoints
  # **currently in Beta only**
  #
  # @example Creating catalog endpoint object
  #   # With default config
  #   catalog = Iterable::Catalogs.new "catalog-name"
  #   catalog.items
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   catalog = Iterable::Catalogs.new("catalog-name", config)
  class Catalogs < ApiResource
    attr_reader :name

    ##
    #
    # Initialize Catalogs with a catalog name **currently in Beta only**
    #
    # @param name [String] The name of the catalog to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Catalog]
    sig { params(name: String, conf: T.nilable(Iterable::Config)).void }
    def initialize(name, conf = nil)
      @name = name
      super conf
    end

    ##
    #
    # Create a catalog
    #
    # @return [Iterable::Response] A response object
    sig { returns(Iterable::Response) }
    def create
      Iterable.request(conf, base_path).post
    end

    ##
    #
    # Delete a catalog
    #
    # @return [Iterable::Response] A response object
    sig { returns(Iterable::Response) }
    def delete
      Iterable.request(conf, base_path).delete
    end

    ##
    #
    # Get a list of all catalog names
    #
    # @return [Iterable::Response] A response object
    sig { params(params: Hash).returns(Iterable::Response) }
    def names(params = {})
      Iterable.request(conf, '/catalogs', params).get
    end

    sig { returns(String) }
    private def base_path
      "/catalogs/#{@name}"
    end
  end
end
