# Spoof is a tiny mocking script.
module Spoof

  # Defines a mock class.
  def self.make(*ancestors)
    superclass = ancestors.shift if ancestors.first.is_a?(Class)
    superclass ||= Object
    mixins = ancestors
    klass = Class.new(superclass) do
      mixins.each { |mixin| send :include, mixin }
      def initialize(*args)
        @args = args
        super unless self.class.superclass == Object
      end
    end
    klass.extend Spoof
    klass.send :include, Spoof
    Object.const_set "Spoof#{klass.object_id}", klass
    klass
  end

  # Creates an attribute getter & setter.
  # @param [Symbol] name The name of the attribute.
  # @param [Object] default_value An optional default value.
  def attr(name, default_value=nil)
    context.send :attr_accessor, name
    instance_variable_set "@#{name}", default_value
  end

  # Creates attributes for a list of names.
  # @param [Symbol] names The list of attribute names.
  def attrs(*names)
    names.each { |name| attr(name) }
  end

  # Creates a method.
  # @param [Symbol] name The name of the method.
  # @yield The block that will serve as the method body.
  def method(name, &block)
    context.send :define_method, name, &block
  end

  private

  def context
    @context = class << self; self; end if is_a? Class
    @context ||= self.class
  end

end
