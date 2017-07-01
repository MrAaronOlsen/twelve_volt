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

  def invert!
    @x = -@x
    @y = -@y
  end

  def normalize!
    m = magnitude
    if m > 0 then @x/=m; @y/=m end
  end

  def mult!(value)
    @x *= value
    @y *= value
  end

  def * (value)
    Vector.new(@x*value, @y*value)
  end

  def add!(vector, value = 1)
    @x += vector.x * value
    @y += vector.y * value
  end

  def + (vector)
    Vector.new(@x+vector.x, @y+vector.y)
  end

  def sub!(vector, value = 1)
    @x -= vector.x * value
    @y -= vector.y * value
  end

  def - (vector)
    Vector.new(@x-vector.x, @y-vector.y)
  end

end