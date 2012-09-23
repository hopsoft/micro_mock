# MicroMock

### Perhaps the lightest mocking strategy available

MicroMock is a tiny mocking script.

It doesn't make any assumptions about the testing framework
and leaves assertions/expectations up to you.

This proves to be quite powerful.

```bash
gem install micro_mock
```

```ruby
Mock = MicroMock.make

# mock a class method
Mock.stub(:foo) { # do stuff & perform assertions/expectations }
# mock a class method with args
Mock.stub(:bar) do |a, b, c|
  # do stuff & perform assertions/expectations
end

mock = Mock.new

# mock an instance method
mock.stub(:biz) { # do stuff & perform assertions/expectations }
# mock an instance method with args
mock.stub(:baz) do |a, b, c|
  # do stuff & perform assertions/expectations
end

# use the methods
Mock.foo
Mock.bar 1, 2, 3
mock.biz
mock.baz 1, 2, 3

# perform assertions/expectations with mock method results
assert mock.biz # test unit
mock.biz.should eq true # rspec
```
