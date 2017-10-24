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
    #
    # Export data between a start and end time
    #
    # @param start_time [Time] The start time of the data to export
    # @param end_time [Time] The end time of the data to export
    #
    # @return [Iterable::Response] A response object
    def export(start_time, end_time)
      params = {
        startDateTime: start_time.strftime(Iterable::Export::DATE_FORMAT),
        endDateTime: end_time.strftime(Iterable::Export::DATE_FORMAT)
      }
      Iterable.request(conf, base_path, request_params(params)).get
    end

    ##
    #
    # Export data given a valid range constant [Iterable::Export::RANGES]
    #
    # @param range [Iterable::Export::RANGES] A valid range to export data for
    #
    # @return [Iterable::Response] A response object
    def export_range(range = Iterable::Export::TODAY)
      params = { range: range }
      Iterable.request(conf, base_path, request_params(params)).get
    end

    protected

    def format
      'json'
    end
  end
end
