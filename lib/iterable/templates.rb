# typed: true

module Iterable
  ##
  #
  # Interact with /templates API endpoints
  #
  # @example Creating templates endpoint object
  #   # With default config
  #   templates = Iterable::Templates.new
  #   templates.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Templates.new(config)
  class Templates < ApiResource
    # Template types
    TYPES = [
      BASE_TYPE      = 'Base'.freeze,
      BLAST_TYPE     = 'Blast'.freeze,
      TRIGGERED_TYPE = 'Triggered'.freeze,
      WORKFLOW_TYPE  = 'Workflow'.freeze
    ].freeze

    ##
    #
    # Get all templates
    #
    # @return [Iterable::Response] A response object
    def all(params = {})
      Iterable.request(conf, '/templates', params).get
    end

    def for_client_template_id(client_template_id)
      params = { clientTemplateId: client_template_id }
      Iterable.request(conf, '/templates/getByClientTemplateId', params).get
    end
  end
end
