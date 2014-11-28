require "pry-test"
require "observer"
require "forwardable"
require "coveralls"
Coveralls.wear!

require File.expand_path("../../lib/micro_mock", __FILE__)

class TestMicroMock < PryTest::Test

  test "make" do
    klass = MicroMock.make
    assert klass.is_a?(Class)
    assert klass.ancestors.include?(MicroMock)
    assert klass.new.is_a?(MicroMock)
  end

  test "make with superclass" do
    klass = MicroMock.make(String)
    assert klass.ancestors.include?(String)
    assert klass.new.is_a?(String)
  end

  test "make with superclass & mixins" do
    klass = MicroMock.make(String, Observable, Forwardable)
    assert klass.ancestors.include?(Observable)
    assert klass.ancestors.include?(Forwardable)
    assert klass.new.is_a?(Observable)
    assert klass.new.is_a?(Forwardable)
  end

  test "attr on mock class" do
    klass = MicroMock.make
    klass.attr :foo
    klass.foo = true
    assert klass.foo
  end

  test "attr on mock instance" do
    instance = MicroMock.make.new
    instance.attr :foo
    instance.foo = true
    assert instance.foo
  end

  test "attr on mock class with default value" do
    klass = MicroMock.make
    klass.attr :foo, true
    assert klass.foo
  end

  test "attr on mock instance with default value" do
    instance = MicroMock.make.new
    instance.attr :foo, true
    assert instance.foo
  end

  test "attrs on class" do
    klass = MicroMock.make
    klass.attrs :foo, :bar, :baz
    klass.foo = 1
    klass.bar = 2
    klass.baz = 3
    assert klass.foo == 1
    assert klass.bar == 2
    assert klass.baz == 3
  end

  test "attrs on instance" do
    instance = MicroMock.make.new
    instance.attrs :foo, :bar, :baz
    instance.foo = 1
    instance.bar = 2
    instance.baz = 3
    assert instance.foo == 1
    assert instance.bar == 2
    assert instance.baz == 3
  end

  test "def on class" do
    klass = MicroMock.make
    klass.attr :foo, 2
    klass.def :foo_times_2 do
      foo * 2
    end
    assert klass.foo_times_2 == 4
  end

  test "def on instance" do
    instance = MicroMock.make.new
    instance.attr :foo, 2
    instance.def :foo_times_2 do
      foo * 2
    end
    assert instance.foo_times_2 == 4
  end

  test "def on class with args" do
    klass = MicroMock.make
    klass.def :multiply do |a, b|
      a * b
    end
    assert klass.multiply(2, 10) == 20
  end

  test "def on instance with args" do
    instance = MicroMock.make.new
    instance.def :multiply do |a, b|
      a * b
    end
    assert instance.multiply(2, 10) == 20
  end
end

