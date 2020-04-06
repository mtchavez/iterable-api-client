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
    def initialize(name, conf = nil)
      @name = name
      super conf
    end

    ##
    #
    # Create a catalog
    #
    # @return [Iterable::Response] A response object
    def create
      Iterable.request(conf, base_path).post
    end

    ##
    #
    # Delete a catalog
    #
    # @return [Iterable::Response] A response object
    def delete
      Iterable.request(conf, base_path).delete
    end

    ##
    #
    # Get a list of all catalog names
    #
    # @return [Iterable::Response] A response object
    def names(params = {})
      Iterable.request(conf, '/catalogs', params).get
    end

    ##
    #
    # Get field mappings for a catalog
    #
    # @return [Iterable::Response] A response object
    def field_mappings
      Iterable.request(conf, "#{base_path}/fieldMappings").get
    end

    ##
    #
    # Set a catalog's field mappings (data types)
    #
    # @param [Array] Array of field mapping hashes e.g [{"fieldName":"exampleString","fieldType":"string"}]}
    #
    # @return [Iterable::Response] A response object
    #
    # @example Supplying field mappings
    #   # Fields to update with field types
    #   field_mappings = [{fieldName: 'test-field', fieldType: 'string'}]
    #   catalog = Iterable::Catalog.new "catalog-name"
    #   catalog.update_field_mappings(field_mappings)
    def update_field_mappings(mappings_updates = [])
      body = { mappingsUpdates: mappings_updates }
      Iterable.request(conf, "#{base_path}/fieldMappings").put(body)
    end

    private

    def base_path
      "/catalogs/#{@name}"
    end
  end
end
