module Iterable
  ##
  #
  # Interact with /catalogs/{catalogName}/{itemID} API endpoints
  # **currently in Beta only**
  #
  # @example Creating catalog items endpoint object
  #   # With default config
  #   catalog = Iterable::CatalogItems.new "catalog-name"
  #   catalog.items
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   catalog = Iterable::CatalogItems.new("catalog-name", config)
  class CatalogItems < ApiResource
    attr_reader :catalog, :item_id

    ##
    #
    # Initialize CatalogItems with a catalog name and item ID **currently in Beta only**
    #
    # @param catalog [String] The name of the catalog to interact with
    # @param item_id [String] The string ID of the item to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Catalog]
    def initialize(catalog, item_id = nil, conf = nil)
      @catalog = catalog
      @item_id = item_id
      super conf
    end

    ##
    #
    # Get all items for a catalog
    #
    # @param params[Hash] Attribute hash for item query (page, pageSize, orderBy, sortAscending)
    #
    # @return [Iterable::Response] A response object
    def all(params = {})
      Iterable.request(conf, base_path, params).get
    end

    ##
    #
    # Create a catalog item
    #
    # @param item_attrs [Hash] Item attributes to save or replace with
    #
    # @return [Iterable::Response] A response object
    def create(item_attrs = {})
      body = { value: item_attrs }
      Iterable.request(conf, base_path).put(body)
    end
    alias replace create

    ##
    #
    # Update a catalog item
    #
    # @param item_attrs [Hash] Item attributes to save or update with
    #
    # @return [Iterable::Response] A response object
    def update(item_attrs = {})
      body = { update: item_attrs }
      Iterable.request(conf, base_path).patch(body)
    end

    ##
    #
    # Get a specific catalog item
    #
    # @return [Iterable::Response] A response object
    def get
      Iterable.request(conf, base_path).get
    end

    ##
    #
    # Delete a catalog item
    #
    # @return [Iterable::Response] A response object
    def delete
      Iterable.request(conf, base_path).delete
    end

    private def base_path
      path = "/catalogs/#{@catalog}/items"
      path += "/#{@item_id}" if @item_id
      path
    end
  end
end
