module Iterable
  ##
  #
  # Interact with /events API endpoints
  #
  # @example Creating events endpoint object
  #   # With default config
  #   campaigns = Iterable::Events.new
  #   campaigns.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   campaigns = Iterable::Events.new(config)
  class Events < ApiResource
    ##
    #
    # Get all events for a user by email
    #
    # @param email [String] Email of user to find events for
    # @param limit [Integer] Limit of events to return, max 200 default 30
    #
    # @return [Iterable::Response] A response object
    def for_email(email, limit = 30)
      Iterable.request(conf, "/events/#{email}", limit: limit).get
    end

    ##
    #
    # Track an event
    #
    # @param name [String] Required name of event
    # @param attrs [Hash] Event values and fields to include
    #
    # @return [Iterable::Response] A response object
    def track(name, email = nil, attrs = {})
      event_data = attrs.merge(eventName: name, email: email)
      Iterable.request(conf, '/events/track').post(event_data)
    end
  end
end
