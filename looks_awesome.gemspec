# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'looks_awesome/version'

Gem::Specification.new do |spec|
  spec.name          = "looks_awesome"
  spec.version       = LooksAwesome::VERSION
  spec.authors       = ["Rentify"]
  spec.email         = ["alex@rentify.com"]
  spec.description   = %q{Adds a method it_looks_nice to your rspecs, that allow you to check your css in your site using screenshots}
  spec.summary       = %q{Adds a method it_looks_nice to your rspecs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
