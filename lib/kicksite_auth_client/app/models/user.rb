require_relative '../helpers/kicksite_auth_base'

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
    response = self.post(:sessions)
    JSON.parse(response.body)
  end
end