module Iterable
  ##
  #
  # Interact with /export API endpoints
  #
  # @example Creating an export endpoint object
  #   # With default config
  #   export = Iterable::Export.new
  #   export = Iterable::Export.new Iterable::Export::EMAIL_SEND_TYPE
  #   export.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   export = Iterable::Export.new(Iterable::Export::EMAIL_SEND_TYPE, nil, nil, nil, config)
  class Export < ApiResource
    DATE_FORMAT = '%Y-%m-%d %H:%M:%S'.freeze
    DATA_TYPES = [
      EMAIL_SEND_TYPE = 'emailSend'.freeze,
      EMAIL_OPEN_TYPE = 'emailOpen'.freeze,
      EMAIL_CLICK_TYPE = 'emailClick'.freeze,
      EMAIL_UNSUBSCRIBE_TYPE = 'emailUnSubscribe'.freeze,
      EMAIL_SUBSCRIBE_TYPE = 'emailSubscribe'.freeze,
      EMAIL_BOUNCE_TYPE = 'emailBounce'.freeze,
      EMAIL_COMPLAINT_TYPE = 'emailComplaint'.freeze,
      PUSH_SEND_TYPE = 'pushSend'.freeze,
      PUSH_BOUNCE_TYPE = 'pushBounce'.freeze,
      PUSH_OPEN_TYPE = 'pushOpen'.freeze,
      SMS_SEND_TYPE = 'smsSend'.freeze,
      SMS_BOUNCE_TYPE = 'smsBounce'.freeze,
      SMS_RECEIVED_TYPE = 'smsReceived'.freeze,
      IN_APP_OPEN_TYPE = 'inAppOpen'.freeze,
      IN_APP_CLICK_TYPE = 'inAppClick'.freeze,
      WEB_PUSH_SEND_TYPE = 'webPushSend'.freeze,
      HOSTED_UNSUBSCRIBE_CLICK_TYPE = 'hostedUnsubscribeClick'.freeze,
      PURCHASE_TYPE = 'purchase'.freeze,
      CUSTOM_EVENT_TYPE = 'customEvent'.freeze,
      USER_TYPE = 'user'.freeze
    ].freeze

    RANGES = [
      TODAY = 'Today'.freeze,
      YESTERDAY = 'Yesterday'.freeze,
      BEFORE_TODAY = 'BeforeToday'.freeze,
      ALL = 'All'.freeze
    ].freeze

    attr_reader :data_type, :only_fields, :omit_fields, :campaign_id

    ##
    #
    # Initialize an [Iterable::Export] object to export data from Iterable
    #
    # @param data_type [String] The type of data to export, one of [Iterable::Export::DATA_TYPES]
    # @param only_fields [Array[String]] Array of fields to only export
    # @param omit_fields [Array[String]] Array of fields to omit
    # @param data_fields [Hash] Additional device data fields
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Export]
    def initialize(data_type, only_fields = [], omit_fields = [], campaign_id = nil, conf = nil)
      @data_type = data_type
      @only_fields = only_fields
      @omit_fields = omit_fields
      @campaign_id = campaign_id
      super conf
    end

    ##
    # The format of the exporter to be implemented by a subclass
    #
    # @example Formats are currently csv or json
    #
    # @return [Exception] Raises an exception
    def format
      raise '#format must be implemented in child class'
    end

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

    protected def base_path
      "/export/data.#{format}"
    end

    protected def request_params(params = {})
      default_params.merge params
    end

    protected def only_fields?
      @only_fields&.length.to_i.positive?
    end

    protected def omit_fields?
      @omit_fields&.length.to_i.positive?
    end

    protected def default_params
      params = { dataTypeName: @data_type }
      params[:onlyFields] = @only_fields if only_fields?
      params[:omitFields] = @omit_fields.join(',') if omit_fields?
      params[:campaignId] = @campaign_id if @campaign_id
      params
    end
  end
end
