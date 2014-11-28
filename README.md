[![Lines of Code](http://img.shields.io/badge/lines_of_code-35-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](http://img.shields.io/codeclimate/github/hopsoft/micro_mock.svg?style=flat)](https://codeclimate.com/github/hopsoft/micro_mock)
[![Dependency Status](http://img.shields.io/gemnasium/hopsoft/micro_mock.svg?style=flat)](https://gemnasium.com/hopsoft/micro_mock)

# MicroMock

A small mocking "framework" to help you write more effective tests.

*Also, checkout [pry-test](https://github.com/hopsoft/pry-test) for a lightweight test framework.*

## Quick Start

```bash
gem install micro_mock
```

```ruby
# create a mock class
MyMock = MicroMock.make

# add a class attr
MyMock.attr(:foo)

# add several class attrs at once
mock.attrs(:one, :two, :three)

# add a class attr with a default value
MyMock.attr(:attr_with_default, "Class value")

# add a class method
MyMock.def(:say_foo) { |arg| "#{foo} #{arg}!" }

# create a mock instance
mock = MyMock.new

# add an instance attr
mock.attr(:bar)

# add several instance attrs at once
mock.attrs(:first, :second, :third)

# add an instance attr with a default value
mock.attr(:attr_with_default, "Instance value")

# add an instance method
mock.def(:say_bar) { |arg| "#{bar} #{arg}!" }

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
MockList = MicroMock.make(Array, Useless)

list = MockList.new

# demonstrate that the mock has inherited behavior
list.concat [1, 2, 3]
list.reverse_string # => "3,2,1"

# add an instance method that does something interesting
list.def :prefixed do |prefix|
  map { |value| "#{prefix}:#{value}"}
end
list.prefixed(:num) # => ["num:1", "num:2", "num:3"]
```

## Deep Cuts

Here is an example that mocks part of ActiveRecord.

```ruby
Model = MicroMock.make
model = Model.new
model.def(:destroy) { @destroyed = true }
model.def(:destroyed?) { @destroyed }
model.def(:update_attributes) { |*args| @attributes_updated = true }
model.def(:save) { |*args| @saved = true }
Model.def(:find) { |*args| model.clone }
Model.def(:all) { (1..5).map { model.clone } }

# try it out
list = Model.all # => [#<MicroMock70331390241500:0x007fee9b1b1bb0 @args=[]>, #<MicroMock...]
m = Model.find(1) # => #<MicroMock70331390241500:0x007fee9b17b6a0 @args=[]>
m.update_attributes(:foo, "bar") # => true
m.save # => true
m.destroy # => true
m.destroyed? # => true
```

For a more complete example, check out [Coast's test suite](https://github.com/hopsoft/coast/blob/master/test/test_coast.rb) which mocks a significant portion of Rails.

