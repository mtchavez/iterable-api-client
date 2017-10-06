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
    # Bulk update user data or adds it if does not exist. Data is merged and
    # missing fields are not deleted
    #
    # @param users [Array[Hash]] Array of hashes of user details
    #
    # @return [Iterable::Response] A response object
    #
    # @note User fields can be email [String], dataFields [Hash], or userId [String]
    def bulk_update(users = [])
      Iterable.request(conf, '/users/bulkUpdate').post(users: users)
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
    # Update a user email
    #
    # @param email [String] The email of the user to get
    #
    # @return [Iterable::Response] A response object
    def update_email(email, new_email)
      attrs = { currentEmail: email, newEmail: new_email }
      Iterable.request(conf, '/users/updateEmail').post(attrs)
    end

    ##
    #
    # Delete a user by their email
    #
    # @param email [String] The email of the user to delete
    #
    # @return [Iterable::Response] A response object
    def delete(email)
      Iterable.request(conf, "/users/#{email}").delete
    end

    ##
    #
    # Delete a user by their userId
    #
    # @param user_id [String] The userId of the user to delete
    #
    # @return [Iterable::Response] A response object
    def delete_by_id(user_id)
      Iterable.request(conf, "/users/byUserId/#{user_id}").delete
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

    ##
    #
    # Get the user fields with mappings from field to type
    #
    # @return [Iterable::Response] A response object
    def fields
      Iterable.request(conf, '/users/getFields').get
    end

    ##
    #
    # Register a browser token for a user
    #
    # @param email [String] An email of a user
    # @param token [String] The browser token to register
    # @param attrs [Hash] Additional attrs like userId to pass along
    #
    # @return [Iterable::Response] A response object
    #
    # @note An email or userId is required
    def register_browser_token(email, token, attrs = {})
      attrs[:email] = email
      attrs[:browserToken] = token
      Iterable.request(conf, '/users/registerBrowserToken').post(attrs)
    end
  end
end
