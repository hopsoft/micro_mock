# MicroMock

### A tiny mocking script.

MicroMock doesn't make any assumptions about the testing framework.
It leaves assertions/expectations up to you.

Calling it a mocking script is a bit of a misnomer
since its really a dynamic class generator.
The term "stub" is used loosely since it adds real behavior...
and "mocking" a class with real behavior proves to be quite useful.

## Intall
```bash
gem install micro_mock
```

## Usage
```ruby
Mock = MicroMock.make

# mock a class method
Mock.stub(:foo) { :bar }

# make assertions
assert_equal :bar, Mock.foo # Test::Unit
Mock.foo.should eq :bar # RSpec

# mock an instance method
m = Mock.new
m.stub(:bar) { :foo }

# make assertions
assert_equal :foo, m.bar # Test::Unit
m.bar.should eq :foo # RSpec

# setup mock internal behavior
count = 1
m.stub(:a) { count += 1 }
m.stub(:b) { |i| self.a if i > 5 }

# make assertions
10.times { |i| m.b(i) }
assert_equal 5, count # Test::Unit
count.should eq 5 # RSpec
```
