require_relative '../helpers/kicksite_auth_base'

# User interactions with REST endpoints
class User < KicksiteAuthBase
  # Authenticate user for use against other endpoints.
  #
  # Example:
  #    User.new(
  #      login: 'username',
  #      password: 'password'
  #    ).authenticate!
  #
  # @return [Hash] Hash with generated token on success
  def authenticate!
    response = post(:sessions)
    JSON.parse(response.body)
  end
end
