module Iterable
  ##
  #
  # Interact with /templates/push API endpoints
  #
  # @example Creating push templates endpoint object
  #   # With default config
  #   templates = Iterable::PushTemplates.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::PushTemplates.new(config)
  class PushTemplates < ApiResource
    ##
    #
    # Get a push template
    #
    # @param template_id [String|Integer] A push template ID
    # @param params [Hash] Additional params to use such as locale
    #
    # @return [Iterable::Response] A response object
    def get(template_id, params = {})
      params['templateId'] = template_id
      Iterable.request(conf, '/templates/push/get', params).get
    end

    ##
    #
    # Update a push template
    #
    # @param template_id [String|Integer] A push template ID
    # @param attrs [Hash] Update attributes
    #
    # @return [Iterable::Response] A response object
    def update(template_id, attrs = {})
      attrs['templateId'] = template_id
      Iterable.request(conf, '/templates/push/update').post(attrs)
    end

    ##
    #
    # Upsert a push template by client template ID
    #
    # @param client_template_id [String] A client template id to use or create
    # @param attrs [Hash] Update attributes
    #
    # @return [Iterable::Response] A response object
    def upsert(client_template_id, attrs = {})
      attrs['clientTemplateId'] = client_template_id
      Iterable.request(conf, '/templates/push/upsert').post(attrs)
    end
  end
end
