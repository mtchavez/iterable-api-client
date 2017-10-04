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
    # @param template_id [String|Integer] An email template id
    # @param params [Hash] Additional params to use such as locale
    #
    # @return [Iterable::Response] A response object
    def get(template_id, params = {})
      params['templateId'] = template_id
      Iterable.request(conf, '/templates/email/get', params).get
    end
  end
end
