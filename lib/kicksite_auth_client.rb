Dir["#{File.dirname(__FILE__)}/kicksite_auth_client/**/*.rb"].sort.each { |file| require file }

# Entry to REST api model definitions
module KicksiteAuthClient
  # Note: Anyone consuming this should mock the actual REST calls in their tests
  unless ENV['RAILS_ENV'] == 'test'
    raise 'Set KICKSITE_AUTH_URL environment variable to utilize this gem' if ENV['KICKSITE_AUTH_URL'].blank?
  end
end
