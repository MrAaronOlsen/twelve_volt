class Vector
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

# Direction and magnitude

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

# Vector math

  # multiplication

  def * (value)
    Vector.new(@x*value, @y*value)
  end

  def scale!(value)
    @x *= value
    @y *= value
  end

  def mult!(vector)
    @x *= vector.x
    @y *= vector.y
  end

  def mult(vector)
    Vector.new(@x *= vector.x, @y *= vector.y)
  end

  # addition

  def + (vector)
    Vector.new(@x+vector.x, @y+vector.y)
  end

  def add!(vector)
    @x+vector.x
    @y+vector.y
  end

  def add_scaled!(vector, value = 1)
    @x += vector.x * value
    @y += vector.y * value
  end

  # subtraction

  def - (vector)
    Vector.new(@x-vector.x, @y-vector.y)
  end

  def sub!(vector)
    @x -= vector.x
    @y -= vector.y
  end

  def sub_scaled!(vector, value = 1)
    @x -= vector.x * value
    @y -= vector.y * value
  end
end