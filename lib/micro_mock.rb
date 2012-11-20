# MicroMock is a tiny mocking script.
module MicroMock

  # Defines a mock class.
  def self.make(superclass=Object)
    klass = Class.new(superclass) do
      def initialize(*args)
        @args = args
        super unless self.class.superclass == Object
      end
    end
    klass.extend MicroMock
    klass.send :include, MicroMock
    Object.const_set "MicroMock#{klass.object_id}", klass
    klass
  end

  # Creates an attribute getter & setter.
  # @param [Symbol] name The name of the attribute.
  def attr(name)
    context.send :attr_accessor, name
  end

  # Stubs a method.
  # The term stub is used loosely since it adds real functionality.
  # @param [Symbol] name The name of the method.
  # @yield The block that will serve as the method definition.
  def stub(name, &block)
    context.send :define_method, name, &block
  end

  private

  def context
    @context = class << self; self; end if is_a? Class
    @context ||= self.class
  end

end
