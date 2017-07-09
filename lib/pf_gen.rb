class PFGen

  def gravity(force)
    @force = Gravity.new(force)
  end

  def drag(force)
    @force = Drag.new(force)
  end

  def update(particle, duration)
    unless particle.mass == 0
      @force.update(particle, duration)
    end
  end

  class Gravity
    attr_accessor :gravity

    def initialize(force)
      @gravity = force
    end

    def update(particle, duration)
      particle.add_force(@gravity * particle.mass)
    end
  end

  class Drag
    attr_accessor :drag

    def initialize(force)
      @k1 = force
      @k2 = @k1 ** 2
    end

    def update(particle, duration)
      force = particle.velocity.copy

      drag_coeff = force.magnitude
      drag_coeff = @k1 * drag_coeff + @k2 * drag_coeff * drag_coeff

      force.normalize!
      force.mult!(-drag_coeff)
      particle.add_force(force)
    end
  end
end