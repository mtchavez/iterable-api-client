module Iterable
  ##
  #
  # Interact with /workflows API endpoints
  #
  # @example Creating workflows endpoint object
  #   # With default config
  #   templates = Iterable::Workflows.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Workflows.new(config)
  class Workflows < ApiResource
    ##
    #
    # Trigger a workflow for an email or a list.
    #
    # @param workflow_id [Integer] workflow_id to trigger
    # @param attrs [Hash] Additional data fields
    #
    # @return [Iterable::Response] A response object
    #
    # @note An email or listId is required to trigger a workflow
    def trigger(workflow_id, attrs = {})
      attrs['workflowId'] = workflow_id
      Iterable.request(conf, '/workflows/triggerWorkflow').post(attrs)
    end
  end
end
