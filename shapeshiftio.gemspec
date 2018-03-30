# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shapeshiftio/version'

Gem::Specification.new do |spec|
  spec.name          = "shapeshiftio"
  spec.version       = Shapeshiftio::VERSION
  spec.authors       = ["Ricardo Malafaia"]
  spec.email         = ["ricardo.malafaia1994@gmail.com"]

  spec.summary       = %q{A complete Ruby wrapper for the shapeshift.io API.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/rbm4/shapeshiftio"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

end
