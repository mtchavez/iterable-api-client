# typed: true

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
    extend T::Sig

    attr_reader :catalog

    ##
    #
    # Initialize CatalogFieldMappings with a catalog name **currently in Beta only**
    #
    # @param catalog [String] The name of the catalog to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Catalog]
    sig { params(catalog: String, conf: T.any(Iterable::Config, NilClass)).void }
    def initialize(catalog, conf = nil)
      @catalog = catalog
      super conf
    end

    ##
    #
    # Get field mappings for a catalog
    #
    # @return [Iterable::Response] A response object
    sig { returns(Iterable::Response) }
    def get
      Iterable.request(conf, base_path).get
    end

    ##
    #
    # Set a catalog's field mappings (data types)
    #
    # @param mappings_updates [Array] Array of field mapping hashes
    #  e.g [{"fieldName":"exampleString","fieldType":"string"}]}
    #
    # @return [Iterable::Response] A response object
    #
    # @example Supplying field mappings
    #   # Fields to update with field types
    #   field_mappings = [{fieldName: 'test-field', fieldType: 'string'}]
    #   catalog = Iterable::CatalogFieldMappings.new "catalog-name"
    #   catalog.update_field_mappings(field_mappings)
    sig { params(mappings_updates: Array).returns(Iterable::Response) }
    def update(mappings_updates = [])
      body = { mappingsUpdates: mappings_updates }
      Iterable.request(conf, base_path).put(body)
    end

    sig { returns(String) }
    private def base_path
      "/catalogs/#{@catalog}/fieldMappings"
    end
  end
end
