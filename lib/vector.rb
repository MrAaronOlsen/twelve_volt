class Vector
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def magnitude
    Math.sqrt(sqrt_magnitude)
  end

  def sqrt_magnitude
    @x*@x + @y*@y
  end

  def invert
    @x = -@x
    @y = -@y
  end

  def normalize
    m = magnitude
    if m > 0 then @x/=m; @y/=m end
  end
end