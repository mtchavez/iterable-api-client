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
    # @param email [String] Email of user to track event for
    # @param attrs [Hash] Event values and fields to include
    #
    # @return [Iterable::Response] A response object
    def track(name, email = nil, attrs = {})
      attrs[:eventName] = name
      attrs[:email] = email
      Iterable.request(conf, '/events/track').post(attrs)
    end

    ##
    #
    # Bulk Track events
    #
    # @param events [Array[Hash]] Array of hashes of event details
    #
    # @return [Iterable::Response] A response object
    #
    # @note Event fields can be eventName [String], email [String], dataFields [Hash], or userId [String]
    def track_bulk(events = [])
      Iterable.request(conf, '/events/trackBulk').post(events: events)
    end

    ##
    #
    # Track an event
    #
    # @param campaign_id [String] Campaign ID of the push event to track
    # @param message_id [String] Message ID of the push event to track
    # @param email [String] Email of user to track push event for
    # @param attrs [Hash] Event values and fields to include
    #
    # @return [Iterable::Response] A response object
    def track_push_open(campaign_id, message_id, email, attrs = {})
      attrs[:campaignId] = campaign_id
      attrs[:messageId] = message_id
      attrs[:email] = email
      Iterable.request(conf, '/events/trackPushOpen').post(attrs)
    end
  end
end
