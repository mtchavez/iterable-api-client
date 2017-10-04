module Iterable
  ##
  #
  # Interact with /templates/email API endpoints
  #
  # @example Creating email templates endpoint object
  #   # With default config
  #   templates = Iterable::EmailTemplates.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::EmailTemplates.new(config)
  class EmailTemplates < ApiResource
    ##
    #
    # Get an email template
    #
    # @param template_id [String|Integer] An email template ID
    # @param params [Hash] Additional params to use such as locale
    #
    # @return [Iterable::Response] A response object
    def get(template_id, params = {})
      params['templateId'] = template_id
      Iterable.request(conf, '/templates/email/get', params).get
    end

    ##
    #
    # Update an email template
    #
    # @param template_id [String|Integer] An email template ID
    # @param attrs [Hash] Update attributes
    #
    # @return [Iterable::Response] A response object
    def update(template_id, attrs = {})
      attrs['templateId'] = template_id
      Iterable.request(conf, '/templates/email/update').post(attrs)
    end

    ##
    #
    # Upsert an email template by client template ID
    #
    # @param client_template_id [String] A client template id to use or create
    # @param attrs [Hash] Update attributes
    #
    # @return [Iterable::Response] A response object
    def upsert(client_template_id, attrs = {})
      attrs['clientTemplateId'] = client_template_id
      Iterable.request(conf, '/templates/email/upsert').post(attrs)
    end
  end
end
