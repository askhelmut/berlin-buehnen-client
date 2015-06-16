lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'berlin_buehnen/version'

Gem::Specification.new do |spec|
  spec.name        = 'berlin-buehnen-client'
  spec.version     = BerlinBuehnen::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Niels Hoffmann"]
  spec.email       = ["niels@askhelmut.com"]
  spec.homepage    = 'https://askhelmut.com'
  spec.summary     = "A wrapper for the BerlinBuehnen REST api."
  spec.description = "A wrapper for the BerlinBuehnen REST api. It provides simple methods to retireve resources form the BerlinBuehnen REST api."
  spec.license     = 'MIT'

  spec.required_rubygems_version = '>= 1.3.5'

  spec.add_runtime_dependency 'httmultiparty', '~> 0.3', '>= 0.3.0'

  spec.add_development_dependency('bundler', '~> 1.0')
  spec.add_development_dependency('guard', '~> 2.0')
  spec.add_development_dependency('rb-fsevent', '~> 0.9')

  spec.files        = Dir.glob("lib/**/*") + %w(README.md)
  spec.require_path = 'lib'
end
