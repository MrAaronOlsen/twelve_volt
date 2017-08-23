class Particle
  attr_accessor :position, :velocity, :acceleration, :damping
  attr_reader :mass, :inverse_mass, :forces

  def initialize(pos = Vector.new, vel = Vector.new, acc = Vector.new)
    @position, @velocity, @acceleration = pos, vel, acc

    @mass = 0.0; set_inverse_mass

    @damping = 0.999
    @forces = Vector.new
  end

  def mass=(mass)
    @mass = mass
    set_inverse_mass
  end

  def integrate(duration)

    unless @mass.zero?
      @position.add_scaled!(@velocity, duration)

      resulting_arc = @acceleration.copy
      resulting_arc.add_scaled!(forces, inverse_mass)
      @velocity.add_scaled!(resulting_arc, duration)

      @velocity.scale!( @damping**duration )

      clear_forces
    end
  end

  def add_force(force)
    @forces.add!(force)
  end

  def clear_forces
    @forces = Vector.new
  end

  private

  def set_inverse_mass
    unless @mass <= 0.0
      @inverse_mass = 1.0/@mass
    else
      @inverse_mass = 0.0
    end
  end
end