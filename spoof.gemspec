require "rake"
require File.expand_path("../lib/spoof/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "spoof"
  spec.version     = Spoof::VERSION
  spec.license     = "MIT"
  spec.homepage    = "http://hopsoft.github.com/spoof/"
  spec.summary     = "A small \"mocking framework\" to help you write more effective tests."
  spec.description = "A small \"mocking framework\" to help you write more effective tests."
  spec.authors     = ["Nathan Hopkins"]
  spec.email       = ["natehop@gmail.com"]
  spec.files       = FileList[
    "lib/**/*.rb",
    "LICENSE.txt",
    "README.md"
  ]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry-test"
  spec.add_development_dependency "coveralls"
end
