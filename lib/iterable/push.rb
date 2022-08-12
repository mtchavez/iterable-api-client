module Iterable
  ##
  #
  # Interact with /push API endpoints
  #
  # @example Creating push templates endpoint object
  #   # With default config
  #   templates = Iterable::PushTemplates.new
  #   templates.get
  #
  class Push < ApiResource
    ##
    #
    # Send a push notification to a specific user
    #
    # @param email [String] (optional) User email used to identify user
    # @param campaign_id [Integer] Campaign ID
    # @param attrs [Hash] Additional data to update or add
    #
    # @return [Iterable::Response] A response object
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
    # @param campaignId [Integer] campaignID used to cancel push
    # @param attrs [Hash] Additional data to update or add
    #
    # @return [Iterable::Response] A response object
    #
    # @note An email or UserId is required
    def cancel(email: nil, campaign_id: nil, attrs: {})
      attrs['email'] = email if email
      attrs['campaignId'] = campaign_id if campaign_id
      Iterable.request(conf, '/push/cancel').post(attrs)
    end
  end
end
