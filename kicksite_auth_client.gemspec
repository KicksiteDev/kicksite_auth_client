lib = File.expand_path('lib', __dir__) # rubocop:disable Gemspec/RequiredRubyVersion
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kicksite_auth_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'kicksite_auth_client'
  spec.version       = KicksiteAuthClient::VERSION
  spec.authors       = ['Lee DeBoom']
  spec.email         = ['lee@kicksite.net']

  spec.summary       = 'REST endpoint definitions to kicksite auth backend'
  spec.description   = 'Utilize for authenticating a user within a given context'
  spec.homepage      = 'https://github.com/jneef/kicksite_auth_client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeresource'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
