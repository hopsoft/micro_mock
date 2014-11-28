require "rake"
require File.expand_path("../lib/micro_mock/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name = "micro_mock"
  spec.version = MicroMock::VERSION
  spec.license = "MIT"
  spec.homepage = "http://hopsoft.github.com/micro_mock/"
  spec.summary = "A small mocking framework to help you write more effective tests."
  spec.description = "A small mocking framework to help you write more effective tests."
  spec.authors = ["Nathan Hopkins"]
  spec.email = ["natehop@gmail.com"]
  spec.files = FileList[
    "lib/**/*.rb",
    "LICENSE.txt",
    "README.md"
  ]
end
