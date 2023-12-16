# typed: true

module Iterable
  ##
  #
  # Interact with /push API endpoints
  #
  # @example Creating push endpoint object
  #   # With default config
  #   templates = Iterable::Push.new
  #   templates.target campaign_id: '12345'
  #
  class Push < ApiResource
    ##
    #
    # Send a push notification to a specific user
    #
    # @param campaign_id [Integer] Campaign ID
    # @param email [String] (optional) User email used to identify user
    # @param attrs [Hash] Additional data to update or add
    #
    # @return [Iterable::Response] A response object
    sig do
      params(
        campaign_id: T.any(String, Integer),
        email: T.nilable(String),
        attrs: T::Hash[
          T.any(Symbol, String),
          T.any(T::Boolean, String, Integer, Float)
        ]
      ).returns(Iterable::Response)
    end
    def target(campaign_id:, email: nil, attrs: {})
      attrs['recipientEmail'] = email if email
      attrs['campaignId'] = campaign_id
      Iterable.request(conf, '/push/target').post(attrs)
    end

    ##
    #
    # Cancel a push notification to a specific user
    # Must include either an email address AND campaignId, or
    # just a scheduledMessageId provided in the attrs
    #
    # @param email [String] User email to cancel push
    # @param campaign_id [Integer] campaignID used to cancel push
    # @param attrs [Hash] Additional data to update or add
    #
    # @return [Iterable::Response] A response object
    #
    # @note An email or UserId is required
    sig do
      params(
        email: T.nilable(String),
        campaign_id: T.nilable(T.any(String, Integer)),
        attrs: T::Hash[
          T.any(Symbol, String),
          T.any(T::Boolean, String, Integer, Float)
        ]
      ).returns(Iterable::Response)
    end
    def cancel(email: nil, campaign_id: nil, attrs: {})
      attrs['email'] = email if email
      attrs['campaignId'] = campaign_id if campaign_id
      Iterable.request(conf, '/push/cancel').post(attrs)
    end
  end
end
