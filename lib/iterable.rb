# typed: true

require 'json'
require 'net/http'
require 'uri'
require 'sorbet-runtime'

require 'multi_json'

files = %w[
  api_resource
  bulk_catalog_items
  catalogs
  catalog_field_mappings
  catalog_items
  config
  response
  request
  lists
  campaigns
  channels
  events
  in_app
  message_types
  templates
  email_templates
  push_templates
  push
  users
  workflows
  metadata
  metadata_table
  experiments
  email
  device
  commerce
  export
  json_exporter
  csv_exporter
]

files.each { |path| require_relative "./iterable/#{path}" }

##
#
# Iterable module for API interactions
module Iterable
  extend T::Sig

  DATE_FORMAT = '%Y-%m-%d'.freeze

  ##
  #
  # Configure a default [Iterable::Config] object to be used when interacting
  # with API endpoints
  #
  # @example Configuring with token
  #   Iterable.configure do |conf|
  #     conf.token = 'secret-token'
  #   end
  sig { params(block: T.proc.params(arg0: T.untyped).void).returns(Iterable::Config) }
  module_function def configure(&block)
    config.tap(&block)
  end

  ##
  #
  # @return [Iterable::Config] The default config for API endpoints
  sig { returns(Iterable::Config) }
  module_function def config
    @config ||= Config.new
  end

  # @!visibility private
  sig do
    params(
      conf: Iterable::Config,
      path: String,
      params: Hash
    ).returns(Iterable::Request)
  end
  module_function def request(conf, path, params = {})
    T.let(Request.new(conf, path, params), Iterable::Request)
  end
end
