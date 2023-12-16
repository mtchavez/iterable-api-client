# typed: true

module Iterable
  ##
  #
  # Interact with /lists API endpoints
  #
  # @example Creating list endpoint object
  #   # With default config
  #   lists = Iterable::Lists.new
  #   lists.all
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   lists = Iterable::Lists.new(config)
  class Lists < ApiResource
    ##
    #
    # Get all lists
    #
    # @return [Iterable::Response] A response object
    sig { returns(Iterable::Response) }
    def all
      Iterable.request(conf, '/lists').get
    end

    ##
    #
    # Create a new list with a name
    #
    # @param name [String] The name of the list to create
    #
    # @return [Iterable::Response] A response object
    sig { params(name: String).returns(Iterable::Response) }
    def create(name)
      Iterable.request(conf, '/lists').post(name: name)
    end

    ##
    #
    # Delete an existing list given a list id
    #
    # @param list_id [String|Integer] The id of the list to delete
    #
    # @return [Iterable::Response] A response object
    sig { params(list_id: T.any(String, Integer)).returns(Iterable::Response) }
    def delete(list_id)
      Iterable.request(conf, "/lists/#{list_id}").delete
    end

    ##
    #
    # Get users for a list
    #
    # @param list_id [String|Integer] The id of the list
    #
    # @return [Iterable::Response] A response object
    sig { params(list_id: T.any(String, Integer)).returns(Iterable::Response) }
    def users(list_id)
      Iterable.request(conf, '/lists/getUsers', listId: list_id).get
    end

    ##
    #
    # Subscribe users to a list
    #
    # @param list_id [String|Integer] The id of the list
    # @param subscribers [Array[Hash]] An array of hashes of user emails and data fields
    #
    # @return [Iterable::Response] A response object
    sig do
      params(
        list_id: T.any(String, Integer),
        subscribers: T::Array[
          T::Hash[
            T.any(Symbol, String), T.any(Symbol, String)
          ]
        ]
      ).returns(Iterable::Response)
    end
    def subscribe(list_id, subscribers = [])
      attrs = {
        listId: list_id,
        subscribers: subscribers
      }
      Iterable.request(conf, '/lists/subscribe').post(attrs)
    end

    ##
    #
    # Subscribe users to a list
    #
    # @param list_id [String|Integer] The id of the list
    # @param subscribers [Array[Hash]] An array of hashes with an email
    #
    # @return [Iterable::Response] A response object
    sig do
      params(
        list_id: T.any(String, Integer),
        subscribers: T::Array[
          T::Hash[
            T.any(Symbol, String), T.any(Symbol, String)
          ]
        ]
      ).returns(Iterable::Response)
    end
    def unsubscribe(list_id, subscribers = [])
      attrs = {
        listId: list_id,
        subscribers: subscribers
      }
      Iterable.request(conf, '/lists/unsubscribe').post(attrs)
    end
  end
end
