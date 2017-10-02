module Iterable
  ##
  #
  # Interact with /channels API endpoints
  #
  # @example Creating channels endpoint object
  #   # With default config
  #   campaigns = Iterable::Channels.new
  #   campaigns.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   campaigns = Iterable::Channels.new(config)
  class Channels < ApiResource
    ##
    #
    # Get all channels
    #
    # @return [Iterable::Response] A response object
    def all
      Iterable.request(conf, '/channels').get
    end
  end
end
