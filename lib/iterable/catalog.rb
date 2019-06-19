module Iterable
  ##
  #
  # Interact with /catalogs/{catalogName} API endpoints
  #
  # @example Creating catalog endpoint object
  #   # With default config
  #   templates = Iterable::Catalog.new "catalog-name"
  #   templates.items
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Catalog.new("catalog-name", config)
  class Catalog < ApiResource
    attr_reader :name
    ##
    #
    # Initialize a Catalog with a table name
    #
    # @param name [String] The name of the table to interact with
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Catalog]
    def initialize(name, conf = nil)
      @name = name
      super conf
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
    # @return [Iterable::Response] A response object
    def update_field_mappings(mappings_updates)
      body = { mappingsUpdates: mappings_updates.is_a?(Array) ? mappings_updates : [mappings_updates] }
      Iterable.request(conf, "#{base_path}/fieldMappings").put(body)
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
    # Create a catalog
    #
    # @return [Iterable::Response] A response object
    def create
      Iterable.request(conf, base_path).post
    end

    ##
    #
    # Delete a catalog item
    #
    # @return [Iterable::Response] A response object
    def remove(key)
      Iterable.request(conf, base_path(key)).delete
    end

    ##
    #
    # Get a specific catalog item
    #
    # @param key [String] Key of catalog item to get
    #
    # @return [Iterable::Response] A response object
    def get(key)
      Iterable.request(conf, base_path(key)).get
    end

    ##
    #
    # Create or update a catalog item
    #
    # Asynchronous. Create or update the specified catalog item in the given catalog.
    # A catalog item's ID must be unique, contain only alphanumeric characters and
    # dashes, and have a maximum length of 255 characters.
    #
    # If the catalog item already exists, its fields will be updated with the values
    # provided in the request body. Previously existing fields not included in the
    # request body will remain as is. Do not use periods in field names.
    #
    # @param key [String] Key of metadata to add
    # @param value [Hash] JSON representation of catalog item to update.
    #
    # @return [Iterable::Response] A response object
    def update(key, value = {})
      Iterable.request(conf, base_path(key)).patch(update: value)
    end

    ##
    #
    # Create or replace a catalog item
    #
    # Asynchronous. Create or replace the specified catalog item in the given catalog.
    # A catalog item's ID must be unique, contain only alphanumeric characters and
    # dashes, and have a maximum length of 255 characters.
    #
    # If the catalog item already exists, it will be replaced by the value provided
    # in the request body. Do not use periods in field names.
    #
    # @param key [String] Key of metadata to add
    # @param value [Hash] JSON representation of catalog item to update.
    #
    # @return [Iterable::Response] A response object
    def replace(key, value = {})
      Iterable.request(conf, base_path(key)).put(value: value)
    end

    ##
    #
    # Bulk delete catalog items
    #
    # @param keys [Array] Array of catalog items to delete
    #
    # @return [Iterable::Response] A response object
    def bulk_remove(*keys)
      body = { itemIds: Array(*keys).map(&:to_s) }
      Iterable.request(conf, "#{base_path}/items").delete(body)
    end

    ##
    #
    # Get the catalog items for a catalog
    #
    # @param page [Integer] Page number to list (starting at 1)
    # @param page_size [Integer] Number of results to display per page (defaults to 10)
    # @param order [String] Field by which results should be ordered. To also use the sortAscending parameter, this field must have a defined type.
    # @param sort_ascending [Boolean] Sort results by ascending (Defaults to false)
    #
    # @return [Iterable::Response] A response object
    def items(page: 1, page_size: 10, order: nil, sort_ascending: false)
      params = {}
      params[:page] = page if page
      params[:pageSize] = page_size if page_size
      params[:orderBy] = order if order
      params[:sortAscending] = sort_ascending if sort_ascending != nil
      Iterable.request(conf, "#{base_path}/items", params).get
    end

    ##
    #
    # Bulk create catalog items
    #
    # Asynchronous. Create up to 1000 catalog items with a single request.
    # Each of a catalog's items must have a unique ID that contains only
    # alphanumeric characters and dashes and has a maximum length of 255
    # characters. If the catalog already contains an item with the same ID as
    # one provided in the request body, the item in the catalog will be
    # completely overwritten, unless replaceUploadedFieldsOnly is set to
    # true. Do not use periods in field names.
    #
    # @param documents [Hash] Hash mapping keys to value objects
    # @param replace_uploaded_fields_only [Boolean] Whether to replace only the upload fields within each document, not each entire document
    #
    # @return [Iterable::Response] A response object
    def bulk_create(documents: {}, replace_uploaded_fields_only: true)
      body = {
        documents: documents,
        replaceUploadedFieldsOnly: replace_uploaded_fields_only
      }
      Iterable.request(conf, "#{base_path}/items").post(body)
    end

    private

    def base_path(key = nil)
      path = "/catalogs/#{@name}"
      path += "/items/#{key}" if key
      path
    end
  end
end
