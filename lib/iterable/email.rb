module Iterable
  ##
  #
  # Interact with /email API endpoints
  #
  # @example Creating email endpoint object
  #   # With default config
  #   templates = Iterable::Email.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Email.new(config)
  class Email < ApiResource
    ##
    #
    # View an email message sent
    #
    # @param email [String] Email of user who received the message to view
    # @param message_id [String|Integer] Message id for message sent
    #
    # @return [Iterable::Response] A response object
    def view(email, message_id)
      params = { email: email, messageId: message_id }
      Iterable.request(conf, '/email/viewInBrowser', params).get
    end
  end
end
