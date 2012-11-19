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

# stub a class method
MyMock.stub(:foo) { "foo" }

# create a mock instance
mock = MyMock.new

# stub an instance method
mock.stub(:bar) { "#{self.class.foo}bar" }

MyMock.foo # => "foo"
mock.bar # => "foobar"
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
