module Iterable
  ##
  #
  # Interact with /metadata API endpoints
  #
  # @example Creating metadata endpoint object
  #   # With default config
  #   templates = Iterable::Metadata.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Metadata.new(config)
  class Metadata < ApiResource
    ##
    #
    # Get metadata
    #
    # @return [Iterable::Response] A response object
    def get
      Iterable.request(conf, '/metadata').get
    end
  end
end
