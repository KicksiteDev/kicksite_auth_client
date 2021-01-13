require_relative '../helpers/kicksite_auth_base'

module KicksiteAuth
  # User session interactions with REST endpoints
  class UserSession < KicksiteAuthBase
    self.collection_name = 'users'
    self.element_name = 'users'

    USER_SESSION_ATTRIBUTE_EXCLUSIONS = %w[
      login
      password
      email
      username
      context
    ].freeze

    # Authenticate user for use against other endpoints.
    #
    # Examples:
    #    UserSession.new(
    #      username: 'username',
    #      password: 'password'
    #    ).authenticate!
    #
    #    UserSession.new(
    #      email: 'user@domain.com',
    #      password: 'password',
    #      context: {
    #        type: 'School',
    #        id: 123
    #      }
    #    ).authenticate!
    #
    # @return [Hash] Hash with generated token on success
    def authenticate!
      self.login = respond_to?('username') ? username : email
      begin
        response = post(:sessions)
      rescue StandardError
        self.attributes = attributes.except('login')
        self.password = '***********'
        raise
      end

      load_attributes_from_response(response)
      self.attributes = attributes.except(*USER_SESSION_ATTRIBUTE_EXCLUSIONS)
      build_user_session_object(response)
    end

    # Authenticate user for use against other endpoints.
    #
    # Examples:
    #    UserSession.new(
    #      username: 'username',
    #      password: 'password'
    #    ).authenticate
    #
    #    UserSession.new(
    #      email: 'user@domain.com',
    #      password: 'password',
    #      context: {
    #        type: 'School',
    #        id: 123
    #      }
    #    ).authenticate
    #
    # @return [Boolean] True if authentication was successful
    def authenticate
      authenticate!
      true
    rescue ActiveResource::ResourceNotFound
      false
    end

    # Method of validating a user token while also retrieving the user the token is for.
    #
    # Examples:
    #    UserSession.new(
    #      username: 'username',
    #      password: 'password'
    #    ).authenticate!.validate!
    #
    #    UserSession.new(
    #      token: 'SUPER LONG SUPER UNIQUE NUMBER HERE'
    #    ).validate!
    #
    # @return [Hash] Hash with generated user on success
    def validate!
      @persisted = true
      response = post(:sessions)
      load_attributes_from_response(response)
      self.attributes = attributes.except(*USER_SESSION_ATTRIBUTE_EXCLUSIONS)
      build_user_session_object(response)
    end

    def community_login!
      @persisted = true
      response = post(:community)
      byebug
      load_attributes_from_response(response)
      self.attributes = attributes.except(*USER_SESSION_ATTRIBUTE_EXCLUSIONS)
      build_user_session_object(response)
    end

    # Method of validating a user token while also retrieving the user the token is for.
    #
    # Examples:
    #    UserSession.new(
    #      email: 'user@domain.com',
    #      password: 'password'
    #    ).authenticate!.validate
    #
    #    UserSession.new(
    #      token: 'SUPER LONG SUPER UNIQUE NUMBER HERE'
    #    ).validate
    #
    # @return [Type] description_of_returned_object
    def validate
      validate!
      true
    rescue ActiveResource::ResourceNotFound
      false
    end

    private

    # Use the given response to build out a proper UserSession object
    #
    # @param response [Net::HTTPCreated] response from auth-api
    # @return [UserSession] a built out UserSession object
    def build_user_session_object(response)
      user              = KicksiteAuth::User.new(JSON.parse(response.body)['user'])
      user_session      = KicksiteAuth::UserSession.new(JSON.parse(response.body))
      user_session.user = user
      user_session
    end
  end
end
