module Iterable
  ##
  #
  # Interact with /lists API endpoints
  #
  # @example Creating list endpoint object
  #   # With default config
  #   lists = Iterable::Lists.new
  #   lists.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   lists = Iterable::Lists.new(config)
  class Lists < ApiResource
    ##
    #
    # Get all lists
    #
    # @return [Iterable::Response] A response object
    def all
      Iterable.request(conf, '/lists').get
    end
  end
end
