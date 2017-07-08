class Particle
  attr_accessor :position, :velocity, :acceleration, :damping
  attr_reader :mass, :inverse_mass, :forces

  def initialize(pos = Vector.new, vel = Vector.new, acc = Vector.new)
    @position, @velocity, @acceleration = pos, vel, acc

    @mass = 0; set_inverse_mass

    @damping = 0.999
    @forces = []
  end

  def mass=(mass)
    @mass = mass
    set_inverse_mass
  end

  def integrate(duration)
    unless @mass == 0
      @position.add_scaled!(@velocity, duration)

      resulting_arc = @acceleration.copy
      @velocity.add_scaled!(resulting_arc, duration)

      @velocity.scale!( @damping**duration )

      clear_forces
    end
  end

  def add_force(force)
    @forces << force
  end

  def clear_forces
    @forces = []
  end

  private

  def set_inverse_mass
    unless @mass <= 0
      @inverse_mass = 1.0/@mass
    else
      @inverse_mass = 0
    end
  end

end