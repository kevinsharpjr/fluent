# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/version'

Gem::Specification.new do |spec|
  spec.name          = 'fluent'
  spec.version       = Fluent::VERSION
  spec.author        = 'Jeff Nyman'
  spec.email         = 'jeffnyman@gmail.com'
  spec.description   = %q{Provides a semantic DSL to construct a fluent interface for test execution libraries.}
  spec.summary       = %q{A Semantically Clean Fluent Interface Test Framework}
  spec.homepage      = 'https://github.com/jnyman/fluent'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::RUBY

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
