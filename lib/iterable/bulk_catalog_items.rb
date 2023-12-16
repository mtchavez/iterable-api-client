# typed: true

module Iterable
  ##
  #
  # Interact with /catalogs/{catalogName}/items API endpoints
  # **currently in Beta only**
  #
  # @example Creating catalog items endpoint object
  #   # With default config
  #   catalog = Iterable::BulkCatalogItems.new "catalog-name"
  #   catalog.items
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   catalog = Iterable::BulkCatalogItems.new("catalog-name", config)
  class BulkCatalogItems < ApiResource
    attr_reader :catalog

    ##
    #
    # Initialize CatalogItems with a catalog name and item ID **currently in Beta only**
    #
    # @param catalog [String] The name of the catalog to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Catalog]
    sig { params(catalog: String, conf: T.nilable(Iterable::Config)).void }
    def initialize(catalog, conf = nil)
      @catalog = catalog
      super conf
    end

    ##
    #
    # Bulk delete catalog items
    #
    # @param item_ids [Array] Array of catalog items ids to delete
    #
    # @return [Iterable::Response] A response object
    sig { params(item_ids: Array).returns(Iterable::Response) }
    def delete(item_ids = [])
      body = { itemIds: item_ids }
      Iterable.request(conf, base_path).delete(body)
    end

    ##
    #
    # Bulk create catalog items
    #
    # @param items [Hash] Hash of item ID to item attributes e.g. { '123456': { name: 'foo', state: 'open' } }
    # @param replace_uploaded_fields_only [Boolean] Whether to replace only the upload fields within each document,
    #                                               not each entire document. Defaults to false and will replace
    #                                               existing.
    # @return [Iterable::Response] A response object
    sig do
      params(
        items: Hash,
        replace_uploaded_fields_only: T::Boolean
      ).returns(Iterable::Response)
    end
    def create(items = {}, replace_uploaded_fields_only: false)
      body = {
        documents: items,
        replaceUploadedFieldsOnly: replace_uploaded_fields_only
      }
      Iterable.request(conf, base_path).post(body)
    end

    sig { returns(String) }
    private def base_path
      "/catalogs/#{@catalog}/items"
    end
  end
end
