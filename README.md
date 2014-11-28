[![Lines of Code](http://img.shields.io/badge/lines_of_code-36-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](http://img.shields.io/codeclimate/github/hopsoft/spoof.svg?style=flat)](https://codeclimate.com/github/hopsoft/spoof)
[![Dependency Status](http://img.shields.io/gemnasium/hopsoft/spoof.svg?style=flat)](https://gemnasium.com/hopsoft/spoof)
[![Build Status](http://img.shields.io/travis/hopsoft/spoof.svg?style=flat)](https://travis-ci.org/hopsoft/spoof)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/spoof.svg?style=flat)](https://coveralls.io/r/hopsoft/spoof?branch=master)
[![Downloads](http://img.shields.io/gem/dt/spoof.svg?style=flat)](http://rubygems.org/gems/spoof)

# Spoof

A small "mocking framework" to help you write more effective tests.

*Also, checkout [pry-test](https://github.com/hopsoft/pry-test) for a lightweight test framework.*

## Quick Start

```bash
gem install spoof
```

```ruby
# create a mock class
MyMock = Spoof.make

# add a class attr
MyMock.attr(:foo)

# add several class attrs at once
mock.attrs(:one, :two, :three)

# add a class attr with a default value
MyMock.attr(:attr_with_default, "Class value")

# add a class method
MyMock.method(:say_foo) { |arg| "#{foo} #{arg}!" }

# create a mock instance
mock = MyMock.new

# add an instance attr
mock.attr(:bar)

# add several instance attrs at once
mock.attrs(:first, :second, :third)

# add an instance attr with a default value
mock.attr(:attr_with_default, "Instance value")

# add an instance method
mock.method(:say_bar) { |arg| "#{bar} #{arg}!" }

# use the mock
MyMock.attr_with_default # => "Class value"
MyMock.foo # => nil
MyMock.foo = :foo
MyMock.say_foo :bar # => "foo bar!"

mock.attr_with_default # => "Instance value"
mock.bar # => nil
mock.bar = :bar
mock.say_bar :foo # => "bar foo!"
```

## Next Steps

```ruby
# create a useless module to illustrate mocking with ancestors
module Useless
  def reverse_string
    reverse.join(",")
  end
end

# create a mock that subclasses Array and mixes in the Useless module defined above
# note: the superclass must be passed before mixin modules
MockList = Spoof.make(Array, Useless)

list = MockList.new

# demonstrate that the mock has inherited behavior
list.concat [1, 2, 3]
list.reverse_string # => "3,2,1"

# add an instance method that does something interesting
list.method :prefixed do |prefix|
  map { |value| "#{prefix}:#{value}"}
end
list.prefixed(:num) # => ["num:1", "num:2", "num:3"]
```

## Deep Cuts

Here is an example that mocks part of ActiveRecord.

```ruby
Model = Spoof.make
Model.method(:find) { |*args| model.clone }
Model.method(:all) { (1..5).map { model.clone } }

model = Model.new
model.method(:destroy) { @destroyed = true }
model.method(:destroyed?) { @destroyed }
model.method(:update_attributes) { |*args| @attributes_updated = true }
model.method(:save) { |*args| @saved = true }

# try it out
list = Model.all # => [#<Spoof70331390241500:0x007fee9b1b1bb0 @args=[]>, #<Spoof...]
m = Model.find(1) # => #<Spoof70331390241500:0x007fee9b17b6a0 @args=[]>
m.update_attributes(:foo, "bar") # => true
m.save # => true
m.destroy # => true
m.destroyed? # => true
```

For a more complete example, check out [Coast's test suite](https://github.com/hopsoft/coast/blob/master/test/test_coast.rb) which mocks a significant portion of Rails.

