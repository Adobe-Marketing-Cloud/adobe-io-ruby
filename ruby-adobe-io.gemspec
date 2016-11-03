# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adobe_io/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-adobe-io"
  spec.version       = AdobeIo::VERSION
  spec.authors       = ["Jeffrey Walter"]
  spec.email         = ["jwalter@adobe.com"]

  spec.summary       = 'Ruby library to fetch an access token.'
  spec.homepage      = 'TODO: Put your gems website or public repo URL here.'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ['reactor_api']
  spec.require_paths = ["lib"]

  spec.add_dependency "jwt", "~> 1.5.6"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "pry-byebug", "~> 3.4.0"
end
