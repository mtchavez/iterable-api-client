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
  end
end
