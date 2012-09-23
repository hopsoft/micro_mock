# MicroMock

### Perhaps the lightest mocking strategy available

MicroMock is a tiny mocking script.

It doesn't make any assumptions about the testing framework
and leaves assertions/expectations up to you.

This proves to be quite powerful.

## Intall
```bash
gem install micro_mock
```

## Use
```ruby
Mock = MicroMock.make

# mock a class method
Mock.stub :foo do |*args|
  assert_equal 1, args.length # Test::Unit
  args.length.should eq 1 # RSpec
end

mock = Mock.new

# mock an instance method
mock.stub :bar do |*args|
  assert_equal 2, args.length # Test::Unit
  args.length.should eq 2 # RSpec
end

# use the methods
Mock.foo 1
mock.bar 1, 2

# use the result of a mocked method
mock.stub :baz do |*args|
  true
end
assert mock.baz # Test::Unit
mock.baz.should be_true # RSpec
```
