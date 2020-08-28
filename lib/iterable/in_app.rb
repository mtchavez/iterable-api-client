module Iterable
  ##
  #
  # Interact with /inApp API endpoints
  #
  # @example Creating in app endpoint object
  #   # With default config
  #   in_app = Iterable::InApp.new
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   in_app = Iterable::InApp.new(config)
  class InApp < ApiResource
    ##
    #
    # Get in-app messages for a user by email
    #
    # @param email [String] *required* Email of user who received the message to view. Required if no user_id present.
    # @param count [Integer] Number of messages to return, defaults to 1
    # @param attrs [Hash] Hash of query attributes like platform, SDKVersion, etc.
    #
    # @return [Iterable::Response] A response object
    def messages_for_email(email, count: 1, **attrs)
      attrs[:email] = email
      attrs[:count] = count
      messages(attrs)
    end

    ##
    #
    # Get in-app messages for a user by user_id
    #
    # @param email [String] *required* Email of user who received the message to view. Required if no user_id present.
    # @param count [Integer] Number of messages to return, defaults to 1
    # @param attrs [Hash] Hash of query attributes like platform, SDKVersion, etc.
    #
    # @return [Iterable::Response] A response object
    def messages_for_user_id(user_id, count: 1, **attrs)
      attrs[:userId] = user_id
      attrs[:count] = count
      messages(attrs)
    end

    private def messages(**attrs)
      Iterable.request(conf, '/inApp/getMessages', attrs).get
    end
  end
end
