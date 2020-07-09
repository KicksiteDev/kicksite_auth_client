require 'activeresource'

# Our base that primarily just defines the kicksite-auth base url
class KicksiteAuthBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_AUTH_URL']}/v1"

  def to_hash
    hash = {}
    attributes.each do |key, value|
      hash[key.to_s] = if value.present? && value.respond_to?(:to_hash)
                         value.to_hash
                       elsif value.present? && value.respond_to?(:attributes)
                         value.attributes
                       else
                         value
                       end
    end

    hash
  end
end
