require 'rake'
require File.join(File.dirname(__FILE__), "lib", "micro_mock", "version")

Gem::Specification.new do |spec|
  spec.name = 'micro_mock'
  spec.version = MicroMock::VERSION
  spec.license = 'MIT'
  spec.homepage = 'http://hopsoft.github.com/micro_mock/'
  spec.summary = 'A tiny mocking script.'
  spec.description = <<-DESC
    Perhaps the lightest mocking strategy available.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.files       = FileList[
    "lib/**/*.rb",
    "LICENSE.txt",
    "README.md"
  ]

end
