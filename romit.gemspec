# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'romit/version'

Gem::Specification.new do |spec|
  spec.name          = 'romit'
  spec.version       = Romit::VERSION
  spec.authors       = ['Alexander Belov']
  spec.email         = ['git@belov.by']

  spec.summary       = 'Ruby bindings for the Romit API'
  spec.description   = 'Romit is awesome stripe alternative'
  spec.homepage      = 'https://github.com/AlexBelov/romit'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`
               .split("\x0")
               .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('rest-client', '~> 1.4')

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rr'
  spec.add_development_dependency 'shoulda-matchers', '2.8.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
end
