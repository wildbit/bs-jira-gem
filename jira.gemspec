lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jira/version'

Gem::Specification.new do |spec|
  spec.name          = "jira"
  spec.version       = Jira::VERSION
  spec.authors       = ["Chris Ledet"]
  spec.email         = ["chris.ledet@wildbit.com"]
  spec.description   = "Lightweight JIRA client for Beanstalk"
  spec.summary       = "Lightweight JIRA client for Beanstalk"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "turn"
end
