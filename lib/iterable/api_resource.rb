# typed: true

module Iterable
  ##
  #
  # ApiResource is a parent class for rest resources for the
  # Iterable API. It allows for request conifugration to be
  # set per request if needed, otherwise the default global
  # Iterable.config is used
  class ApiResource
    extend T::Sig

    attr_reader :conf

    ##
    #
    # Initialize a new ApiResource with an optional config. Will default to
    # the global [Iterable::Config] via `Iterable.config`
    #
    # @return [Iterable::ApiResource]
    sig { params(conf: T.nilable(Iterable::Config)).void }
    def initialize(conf = nil)
      @conf = conf || default_config
    end

    ##
    #
    # Global Iterable config accessor for class
    #
    # @return [Iterable::Config]
    sig { returns(Iterable::Config) }
    def self.default_config
      Iterable.config
    end

    ##
    #
    # Global Iterable config accessor for instance
    #
    # @return [Iterable::Config]
    sig { returns(Iterable::Config) }
    def default_config
      self.class.default_config
    end
  end
end
