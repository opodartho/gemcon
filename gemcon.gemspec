# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemcon/version'

Gem::Specification.new do |spec|
  spec.name          = "gemcon"
  spec.version       = Gemcon::VERSION
  spec.authors       = ["Zahidul Haque"]
  spec.email         = ["iisowrovii@gmail.com"]

  spec.summary       = %q{Simple console app generator for testing gems.}
  spec.homepage      = "https://github.com/opodartho/gemcon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["gemcon"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", ">=0.18.1", "< 2.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
