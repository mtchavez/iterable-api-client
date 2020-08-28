module Iterable
  ##
  #
  # Interact with /catalogs/{catalogName}/fieldMappings API endpoints
  # **currently in Beta only**
  #
  # @example Creating catalog field mappings endpoint object
  #   # With default config
  #   catalog = Iterable::CatalogFieldMappings.new "catalog-name"
  #   catalog.items
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   catalog = Iterable::CatalogFieldMappings.new("catalog-name", config)
  class CatalogFieldMappings < ApiResource
    attr_reader :catalog
    ##
    #
    # Initialize CatalogFieldMappings with a catalog name **currently in Beta only**
    #
    # @param catalog [String] The name of the catalog to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Catalog]
    def initialize(catalog, conf = nil)
      @catalog = catalog
      super conf
    end

    ##
    #
    # Get field mappings for a catalog
    #
    # @return [Iterable::Response] A response object
    def get
      Iterable.request(conf, base_path).get
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
    #   catalog = Iterable::CatalogFieldMappings.new "catalog-name"
    #   catalog.update_field_mappings(field_mappings)
    def update(mappings_updates = [])
      body = { mappingsUpdates: mappings_updates }
      Iterable.request(conf, base_path).put(body)
    end

    private def base_path
      "/catalogs/#{@catalog}/fieldMappings"
    end
  end
end
