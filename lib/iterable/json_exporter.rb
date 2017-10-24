module Iterable
  ##
  #
  # Subclass of [Iterable::Export] for JSON exporting of data
  #
  # @example Creating a JSON Exporter
  #   # With default config
  #   exporter = Iterable::JsonExporter.new Iterable::Export::EMAIL_SEND_TYPE
  #   exporter.export
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   exporter = Iterable::JsonExporter.new(Iterable::Export::EMAIL_SEND_TYPE, nil, nil, nil, config)
  class JsonExporter < Export
    ##
    # Format to use for exporting
    #
    # @return [String] Format of export
    def format
      'json'
    end
  end
end
