# typed: true

require 'forwardable'

module Iterable
  ##
  #
  # Response class is used to get access to raw HTTP request info
  class Response
    extend Forwardable
    extend T::Sig

    def_delegators :@resp, :code, :message, :uri, :[]

    attr_reader :body

    # @!visibility private
    sig do
      params(
        resp: Net::HTTPResponse
      ).void
    end
    def initialize(resp)
      @resp = resp
      @body = parsed_body
    end

    ##
    #
    # Convenience method to determine if request was successful or not
    # @return [Boolean]
    sig { returns(T::Boolean) }
    def success?
      case @resp.code.to_i
      when (200..299) then true
      else
        false
      end
    end

    ##
    # Attempts to parse the response as JSON. Will rescue and return original
    # if unable to parse.
    #
    # @return [Hash,Array,String] A parsed JSON object or the original response body
    sig do
      returns(
        T.nilable(T.any(Hash, Array, String))
      )
    end
    private def parsed_body
      response_body = @resp.body
      MultiJson.load response_body
    rescue MultiJson::ParseError
      response_body
    end
  end
end
