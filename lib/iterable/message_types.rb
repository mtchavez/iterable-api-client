# typed: true

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
    # Message mediums
    MEDIUMS = [
      EMAIL_MEDIUM  = 'Email'.freeze,
      PUSH_MEDIUM   = 'Push'.freeze,
      IN_APP_MEDIUM = 'InApp'.freeze,
      SMS_MEDIUM    = 'SMS'.freeze
    ].freeze
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
