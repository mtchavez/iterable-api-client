module Iterable
  ##
  #
  # Interact with /campaigns API endpoints
  #
  # @example Creating campaigns endpoint object
  #   # With default config
  #   campaigns = Iterable::Campaigns.new
  #   campaigns.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   campaigns = Iterable::Campaigns.new(config)
  class Campaigns < ApiResource
    ##
    #
    # Get all campaigns
    #
    # @return [Iterable::Response] A response object
    def all
      Iterable.request(conf, '/campaigns').get
    end
  end
end
