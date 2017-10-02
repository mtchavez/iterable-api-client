require 'json'
require 'net/http'
require 'uri'

files = %w[
  api_resource
  config
  response
  request
  lists
  campaigns
]

files.each { |path| require_relative "./iterable/#{path}" }

##
#
# Iterable module for API interactions
module Iterable
  module_function

  ##
  #
  # Configure a default [Iterable::Config] object to be used when interacting
  # with API endpoints
  #
  # @example Configuring with token
  #   Iterable.configure do |conf|
  #     conf.token = 'secret-token'
  #   end
  def configure
    config.tap do |conf|
      yield conf
    end
  end

  ##
  #
  # @return [Iterable::Config] The default config for API endpoints
  def config
    @config ||= Config.new
  end

  # @!visibility private
  def request(conf, path, params = {})
    Request.new conf, path, params
  end
end
