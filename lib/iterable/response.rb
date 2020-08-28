require 'forwardable'

module Iterable
  ##
  #
  # Response class is used to get access to raw HTTP request info
  class Response
    extend Forwardable

    def_delegators :@resp, :code, :message, :uri

    attr_reader :body

    # @!visibility private
    def initialize(resp)
      @resp = resp
      @body = parsed_body
    end

    ##
    #
    # Convenience method to determine if request was successfull or not
    # @return [Boolean]
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
    private def parsed_body
      response_body = @resp.body
      MultiJson.load response_body
    rescue MultiJson::ParseError
      response_body
    end
  end
end
