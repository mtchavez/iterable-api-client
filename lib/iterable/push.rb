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
      def cancel(email: nil, campaign_Id: nil, attrs:{})
        if email
          attrs['email'] = email
        end

        if campaign_Id
          attrs['campaignId'] = campaign_Id
        end
        Iterable.request(conf, '/push/cancel').post(attrs)
      end

      ##
      #
      # Send a push notification to a specific user
      #
      # @param email [String] (optional) User email used to identify user
      # @param campaign_id [Integer] Campaign ID 
      # @param attrs [Hash] Additional data to update or add
      #
      # @return [Iterable::Response] A response object
      def target(email: nil, campaign_Id:, attrs:{})
        if email
          attrs['recipientEmail'] = email
        end
        attrs['campaignId'] = campaign_Id
        Iterable.request(conf, '/push/target').post(attrs)
      end

  end
end