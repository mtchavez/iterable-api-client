module Iterable
  ##
  #
  # Interact with /metadata/{table} API endpoints
  #
  # @example Creating metadata table endpoint object
  #   # With default config
  #   templates = Iterable::MetadataTable.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::MetadataTable.new(config)
  class MetadataTable < ApiResource
    attr_reader :name
    ##
    #
    # Initialize a MetadataTable with a table name
    #
    # @param name [String] The name of the table to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::MetadataTable]
    def initialize(name, conf = nil)
      @name = name
      super conf
    end

    ##
    #
    # Get metadata table keys
    #
    # @params next_marker [String] next result set id if more hits exist
    #
    # @return [Iterable::Response] A response object
    def list_keys(next_marker = nil)
      params = {}
      params['nextMarker'] = next_marker if next_marker
      Iterable.request(conf, base_path, params).get
    end

    ##
    #
    # Delete metadata table
    #
    # @return [Iterable::Response] A response object
    def delete
      Iterable.request(conf, base_path).delete
    end

    ##
    #
    # Add metadata for table
    #
    # @param key [String] Key of metadata to add
    # @param value [Hash] Value of metadata key as a hash of key/value data
    #
    # @return [Iterable::Response] A response object
    def add(key, value = {})
      Iterable.request(conf, base_path(key)).put(value: value)
    end

    ##
    #
    # Get metadata key for table
    #
    # @param key [String] Key of metadata to get
    #
    # @return [Iterable::Response] A response object
    def get(key)
      Iterable.request(conf, base_path(key)).get
    end

    ##
    #
    # Remove metadata key for table
    #
    # @param key [String] Key of metadata to delete
    #
    # @return [Iterable::Response] A response object
    def remove(key)
      Iterable.request(conf, base_path(key)).delete
    end

    private

    def base_path(key = nil)
      path = "/metadata/#{@name}"
      path += "/#{key}" if key
      path
    end
  end
end
