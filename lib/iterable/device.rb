module Iterable
  ##
  #
  # Interact with user device API endpoints
  #
  # @example Creating device endpoint object
  #   # With default config
  #   campaigns = Iterable::Device.new 'token', 'app-name', Iterable::Device::APNS
  #   campaigns.all
  #
  #   # With custom config
  #   conf = Iterable::Device.new(token: 'new-token')
  #   campaigns = Iterable::Device.new('token', 'app-name', Iterable::Device::APNS, config)
  class Device < ApiResource
    PLATFORMS = [
      APNS = 'APNS'.freeze,
      APNS_SANDBOX = 'APNS_SANDBOX'.freeze,
      GCM = 'GCM'.freeze
    ].freeze

    attr_reader :app, :data_fields, :platform, :token

    ##
    #
    # Initialize an [Iterable::Device] to register for a user
    #
    # @param token [String] The device token
    # @param app [String] The application name for mobile push
    # @param platform [String] The device device platform; one of [Iterable::Device::PLATFORMS]
    # @param data_fields [Hash] Additional device data fields
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Device]
    def initialize(token, app, platform, data_fields = {}, conf = nil)
      @token = token
      @app = app
      @platform = platform
      @data_fields = data_fields
      super conf
    end

    ##
    #
    # Register a device for a user email or id
    #
    # @param email [String] Email of user to associate device with
    # @param user_id [String] User ID to associate device with instead of email
    #
    # @return [Iterable::Response] A response object
    def register(email, user_id = nil)
      attrs = {
        device: device_data
      }
      attrs[:email] = email if email
      attrs[:userId] = user_id if user_id
      Iterable.request(conf, base_path).post(attrs)
    end

    private def base_path
      '/users/registerDeviceToken'
    end

    private def device_data
      {
        token: @token,
        applicationName: @app,
        platform: @platform,
        dataFields: @data_fields
      }
    end
  end
end
