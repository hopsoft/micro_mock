# MicroMock is a tiny mocking script.
# It doesn't make any assumptions about the testing framework
# and leaves assertions/expectations up to you.
#
# This proves to be quite powerful.
#
# @example
#   Mock = MicroMock.make
#
#   # mock a class method
#   Mock.stub(:foo) { # do stuff & perform assertions/expectations }
#   # mock a class method with args
#   Mock.stub(:bar) do |a, b, c|
#     # do stuff & perform assertions/expectations
#   end
#
#   mock = Mock.new
#
#   # mock an instance method
#   mock.stub(:biz) { # do stuff & perform assertions/expectations }
#   # mock an instance method with args
#   mock.stub(:baz) do |a, b, c|
#     # do stuff & perform assertions/expectations
#   end
#
#   # use the methods
#   Mock.foo
#   Mock.bar 1, 2, 3
#   mock.biz
#   mock.baz 1, 2, 3
#
#   # perform assertions/expectations with mock method results
#   assert mock.biz # test unit
#   mock.biz.should eq true # rspec
module MicroMock
  # Stubs a method.
  # @param [Symbol] name The name of the method.
  # @yield The block that will serve as the method definition.
  def stub(name, &block)
    context = class << self; self; end if is_a? Class
    context ||= self.class
    context.send :define_method, name, &block
  end

  # Defines a mock class.
  def self.make
    Class.new do
      extend MicroMock
      include MicroMock
    end
  end
end
