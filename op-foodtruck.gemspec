# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'op/foodtruck/version'

Gem::Specification.new do |spec|
  spec.name          = "op-foodtruck"
  spec.version       = Op::Foodtruck::VERSION
  spec.authors       = ["Jon Phillips"]
  spec.email         = ["jphillips@opthumb.com"]
  spec.description   = %q{a client for the food truck api}
  spec.summary       = %q{food truck api client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  puts `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
