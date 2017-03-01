# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wrkflo/version'

Gem::Specification.new do |spec|
  spec.name                   = 'wrkflo'
  spec.version                = Wrkflo::VERSION
  spec.summary                = 'Get working on things faster with predefined wrkflos.'
  spec.platform               = Gem::Platform::RUBY
  spec.required_ruby_version  = '>= 2.2.0'
  spec.date                   = Date.today.strftime('%F')
  spec.author                 = 'Jon Egeland'
  spec.email                  = 'jonegeland@gmail.com'
  spec.homepage               = 'http://github.com/faultyserver/wrkflo'
  spec.license                = 'MIT'

  spec.require_paths          = ["lib", "lib/wrkflo"]
  spec.files                  += Dir['lib/wrkflo/*'] + Dir['lib/wrkflo/**/*']

  spec.add_dependency         "os", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.executables            << 'wrkflo'
end
