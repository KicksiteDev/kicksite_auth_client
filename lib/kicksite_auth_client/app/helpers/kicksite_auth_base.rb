require 'activeresource'

# Our base that primarily just defines the kicksite-auth base url
class KicksiteAuthBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_AUTH_URL']}/v1"
end
