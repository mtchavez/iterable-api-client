# typed: true

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
    # @param attrs [Hash] Hash of attributes to pass like dataFields with the request
    #
    # @return [Iterable::Response] A response object
    sig do
      params(
        email: T.nilable(String),
        message_id: T.any(String, Integer),
        attrs: Hash
      ).returns(Iterable::Response)
    end
    def view(email, message_id, attrs = {})
      attrs['email'] = email
      attrs['messageId'] = message_id
      attrs.compact!

      Iterable.request(conf, '/email/viewInBrowser', attrs).get
    end

    ##
    #
    # Target a user with an email given a campaign
    #
    # @param email [String] Email of user who received the message to view
    # @param campaign_id [Integer] Campaign id to target user for
    # @param attrs [Hash] Hash of attributes to pass like dataFields with the request
    #
    # @return [Iterable::Response] A response object
    sig do
      params(
        email: String,
        campaign_id: Integer,
        attrs: Hash
      ).returns(Iterable::Response)
    end
    def target(email, campaign_id, attrs = {})
      attrs[:recipientEmail] = email
      attrs[:campaignId] = campaign_id
      Iterable.request(conf, '/email/target').post(attrs)
    end
  end
end
