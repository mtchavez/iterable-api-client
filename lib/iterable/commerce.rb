module Iterable
  ##
  #
  # Interact with /commerce API endpoints
  #
  # @example Creating commerce endpoint object
  #   # With default config
  #   commerce = Iterable::Commerce.new
  #   commerce.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   commerce = Iterable::Commerce.new(config)
  class Commerce < ApiResource
    ##
    #
    # Track a purchase. 'shoppingCartItems' field on the user profile is cleared.
    # User profile is also updated (created otherwise) using the user request field
    #
    # @param total [Float] Total order amount
    # @param items [Array[Hash]] Array of hashes of commerce items
    # @param user [Hash] User update request details to update or create user
    # @param attrs [Hash] Track purchase request additional fields
    #
    # @return [Iterable::Response] A response object
    def track_purchase(total, items = [], user = {}, attrs = {})
      data = {
        total: total,
        items: items,
        user: user
      }
      data.merge!(attrs)
      Iterable.request(conf, '/commerce/trackPurchase').post(data)
    end

    ##
    #
    # Updates the 'shoppingCartItems' field on the user profile with shopping
    # cart items. User profile is updated (created otherwise) via the user field.
    #
    # @param user [Hash] User update request details to update or create user
    # @param items [Array[Hash]] Array of hashes of commerce items
    #
    # @return [Iterable::Response] A response object
    def update_cart(user = {}, items = [])
      data = {
        items: items,
        user: user
      }
      Iterable.request(conf, '/commerce/updateCart').post(data)
    end
  end
end
