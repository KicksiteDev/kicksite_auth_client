Dir["#{File.dirname(__FILE__)}/kicksite_auth_client/**/*.rb"].sort.each { |file| require file }

# Entry to REST api model definitions
module KicksiteAuthClient
  # NOTE: Anyone consuming this should mock the actual REST calls in their tests
  if !ENV['RAILS_ENV'] == 'test' && ENV['KICKSITE_AUTH_URL'].blank?
    raise 'Set KICKSITE_AUTH_URL environment variable to utilize this gem'
  end
end
