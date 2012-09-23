require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'micro_mock'
  spec.version = '0.0.1'
  spec.license = 'MIT'
  spec.homepage = 'http://hopsoft.github.com/micro_mock/'
  spec.summary = 'A tiny mocking script.'
  spec.description = <<-DESC
    MicroMock might just be the lightest mocking strategy available.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'spec/**/*.rb'].to_a
end
