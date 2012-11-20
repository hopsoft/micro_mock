# MicroMock

### Perhaps the lightest mocking strategy available

Calling it a mocking script is a bit of a misnomer since its really a dynamic class generator. The term "stub" is used loosely since it adds real behavior...
and "mocking" with real behavior proves to be quite useful.

## Intall

```bash
gem install micro_mock
```

## Quick Start

```ruby
# create a mock class
MyMock = MicroMock.make

# add a class attr
MyMock.attr(:foo)

# stub a class method
MyMock.stub(:say_foo) { |arg| "#{foo} #{arg}!" }

# create a mock instance
mock = MyMock.new

# add an instance attr
mock.attr(:bar)

# stub some instance methods
mock.stub(:say_bar) { |arg| "#{bar} #{arg}!" }

# use the mock
MyMock.foo = :foo
MyMock.say_foo :bar # => "foobar!"

mock.bar = :bar
mock.say_bar :foo # => "barfoo!"
```

## Next Steps

```ruby
# create a mock that subclasses Array
MockList = MicroMock.make(Array)

list = MockList.new

# stub an instance method that does something interesting
list.stub :prefixed do |prefix|
  map { |value| "#{prefix}:#{value}"}
end

list.concat [1, 2, 3]
list.prefixed(:num) # => ["num:1", "num:2", "num:3"]
```

## Deep Cuts

Here is an example that mocks part of ActiveRecord.

```ruby
Model = MicroMock.make
model = Model.new
model.stub(:destroy) { @destroyed = true }
model.stub(:destroyed?) { @destroyed }
model.stub(:update_attributes) { |*args| @attributes_updated = true }
model.stub(:save) { |*args| @saved = true }
Model.stub(:find) { |*args| model.clone }
Model.stub(:all) { (1..5).map { model.clone } }

# try it out
list = Model.all # => [#<MicroMock70331390241500:0x007fee9b1b1bb0 @args=[]>, #<MicroMock...]
m = Model.find(1) # => #<MicroMock70331390241500:0x007fee9b17b6a0 @args=[]>
m.update_attributes(:foo, "bar") # => true
m.save # => true
m.destroy # => true
m.destroyed? # => true
```

For a more complete example, check out [Coast's test suite](https://github.com/hopsoft/coast/blob/master/test/test_coast.rb) which mocks a significant portion of Rails.

Enjoy!
