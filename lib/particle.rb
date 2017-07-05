class Particle
  attr_accessor :position, :velocity, :acceleration

  def initialize(pos = Vector.new, vel = Vector.new, acc = Vector.new)
    @position = pos
    @velocity = vel
    @acceleration = acc
  end

end