# typed: true

module Iterable
  ##
  #
  # Subclass of [Iterable::Export] for CSV exporting of data
  #
  # @example Creating a CSV Exporter
  #   # With default config
  #   exporter = Iterable::CsvExporter.new Iterable::Export::EMAIL_SEND_TYPE
  #   exporter.export
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   exporter = Iterable::CsvExporter.new(Iterable::Export::EMAIL_SEND_TYPE, nil, nil, nil, config)
  class CsvExporter < Export
    sig { override.returns(String) }
    def format
      'csv'
    end
  end
end
