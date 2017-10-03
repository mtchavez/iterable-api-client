module Iterable
  ##
  #
  # Interact with /messageTypes API endpoints
  #
  # @example Creating message_types endpoint object
  #   # With default config
  #   message_types = Iterable::MessageTypes.new
  #   message_types.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   message_types = Iterable::MessageTypes.new(config)
  class MessageTypes < ApiResource
    ##
    #
    # Get all message_types
    #
    # @return [Iterable::Response] A response object
    def all
      Iterable.request(conf, '/messageTypes').get
    end
  end
end
