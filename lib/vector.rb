class Vector
  attr_accessor :x, :y

  def initialize(x = 0.0, y = 0.0)
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
    self.tap { @x = -@x; @y = -@y }
  end

  def inverse
    Vector.new(-@x, -@y)
  end

  def normalize!
    m = magnitude
    self.tap { if m > 0.0 then @x/=m; @y/=m end }
  end

  def normal
    Vector.new(-@y, @x)
  end

# Vector math

  # multiplication

  def * (value)
    Vector.new(@x*value, @y*value)
  end

  def scale!(value)
    self.tap { @x *= value; @y *= value }
  end

  def mult!(vector)
    self.tap { @x *= vector.x; @y *= vector.y }
  end

  def mult(vector)
    Vector.new(@x*vector.x, @y*vector.y)
  end

  def dot(vector)
    @x*vector.x + @y*vector.y
  end

  # addition

  def + (vector)
    Vector.new(@x+vector.x, @y+vector.y)
  end

  def add!(vector)
    self.tap { @x += vector.x; @y += vector.y }
  end

  def add_scaled!(vector, value = 1.0)
    self.tap { @x += vector.x * value; @y += vector.y * value }
  end

  # subtraction

  def - (vector)
    Vector.new(@x-vector.x, @y-vector.y)
  end

  def sub!(vector)
    self.tap { @x -= vector.x; @y -= vector.y }
  end

  def sub_scaled!(vector, value = 1.0)
    self.tap { @x -= vector.x * value; @y -= vector.y * value }
  end

  def copy
    Vector.new(@x, @y)
  end
end