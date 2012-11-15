# MicroMock is a tiny mocking script.
#
# It doesn't make any assumptions about the testing framework.
# It leaves assertions/expectations up to you.
#
# Calling it a mocking script is a bit of a misnomer
# since its really a dynamic class generator.
#
# The term "stub" is used loosely since it adds real behavior...
# and "mocking" a class with real behavior proves to be quite useful.
#
# @example
#   # mock a class method
#   Mock = MicroMock.make
#   Mock.stub(:foo) { true }
#
#   # make assertions
#   assert Mock.foo # Test::Unit
#   Mock.foo.should be_true # RSpec
#
#   # mock an instance method
#   m = Mock.new
#   m.stub(:bar) { false }
#
#   # make assertions
#   assert_equal false, m.bar # Test::Unit
#   m.bar.should eq false # RSpec
#
#   # setup mock internal behavior
#   count = 1
#   m.stub(:a) { count += 1 }
#   m.stub(:b) { |i| self.a if i > 5 }
#
#   # make assertions
#   10.times { |i| m.b(i) }
#   assert_equal 5, count # Test::Unit
#   count.should eq 5 # RSpec
#
# Of course you wouldn't normally test the mock itself... rather the code that uses the mock.
# I'll work on adding some real world examples.
#
# @ example
#   Mock with a superclass.
#   Mock = MicroMock.make(Array)
#   list = Mock.new
#   list << 1
#   list.stub :say_hi do |name|
#     "Hi #{name}!"
#   end
#   list.say_hi "Nate" # => "Hi Nate!"
module MicroMock

  # Stubs a method.
  # The term stub is used loosely since it adds real functionality.
  # @param [Symbol] name The name of the method.
  # @yield The block that will serve as the method definition.
  def stub(name, &block)
    context = class << self; self; end if is_a? Class
    context ||= self.class
    context.send :define_method, name, &block
  end

  # Defines a mock class.
  def self.make(superclass=nil)
    klass = Class.new(superclass) if superclass
    klass ||= Class.new
    klass.extend MicroMock
    klass.send :include, MicroMock
    klass
  end

end
