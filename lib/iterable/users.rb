module Iterable
  ##
  #
  # Interact with /users API endpoints
  #
  # @example Creating users endpoint object
  #   # With default config
  #   templates = Iterable::Users.new
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Users.new(config)
  class Users < ApiResource
    ##
    #
    # Update user data or adds a user if missing. Data is merged - missing
    # fields are not deleted
    #
    # @param email [String] User email to update or create
    # @param attrs [Hash] Additional data to update or add
    #
    # @return [Iterable::Response] A response object
    def update(email, attrs = {})
      attrs['email'] = email
      Iterable.request(conf, '/users/update').post(attrs)
    end

    ##
    #
    # Get a user by their email
    #
    # @param email [String] The email of the user to get
    #
    # @return [Iterable::Response] A response object
    def for_email(email)
      Iterable.request(conf, "/users/#{email}").get
    end

    ##
    #
    # Get a user by their userId
    #
    # @param user_id [String] The user ID of the user to get
    #
    # @return [Iterable::Response] A response object
    def for_id(user_id)
      Iterable.request(conf, "/users/byUserId/#{user_id}").get
    end
  end
end
