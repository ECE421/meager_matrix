class Parent
  def initialize
    @foo = "bar"

  end

  def caller
    puts("test")
    @foo[1] = "testval"
    puts(@foo[1])
  end

  def foo

  end
end

class Child < Parent
  @var
  def initialize
    self.instance_variable_set("@foo", Value.new(self))
  end

  def get_val
    @var
  end

  def set_val(v)
    @var = v
  end
  class Value

    def initialize(child)
      @child = child
    end

    def [](v)
      @child.get_val
    end

    def []=(i,v)
      @child.set_val(v)
    end
  end

  def print_val
    @var
  end
end


c = Child.new
c.caller
puts(c.print_val)