class PContact
  attr_accessor :restitution, :contact_normal, :penetration, :particle_movement
  attr_reader :particles

  def initialize(p1, p2 = nil)
    @particles = [p1, p2]
  end

  def resolve(duration)
    resolve_velocity(duration)
    resolve_interpenetration(duration)
  end

  def get_seperating_velocity
    rel_velocity = @particles[0].velocity.copy
    rel_velocity.sub!(@particles[1].velocity) if @particles[1]

    rel_velocity.dot(contact_normal)
  end

  private

  def resolve_velocity(duration)
    seperating_velocity = get_seperating_velocity

    if seperating_velocity > 0.0
      return
    end

    new_sep_velocity = -seperating_velocity * restitution
    velocity_buildup = @particles[0].acceleration.copy

    if @particles[1]
      velocity_buildup.sub!(@particles[1].acceleration)
    end

    buildup_sep_vel = velocity_buildup.dot(contact_normal.scale!(duration))

    if buildup_sep_vel < 0
      new_sep_velocity += (buildup_sep_vel * restitution)

      if new_sep_velocity < 0
        new_sep_velocity = 0
      end
    end

    delta_velocity = new_sep_velocity - seperating_velocity

    total_i_mass = @particles[0].inverse_mass
    total_i_mass += @particles[1].inverse_mass if @particles[1]

    if total_i_mass <= 0.0
      return
    end

    impulse = delta_velocity / total_i_mass
    impulse_per_i_mass = contact_normal * impulse

    @particles[0].velocity.add!( impulse_per_i_mass * @particles[0].inverse_mass )

    if @particles[1]
      @particles[1].velocity.add!( impulse_per_i_mass * -@particles[1].inverse_mass )
    end
  end

  def resolve_interpenetration(duration)
    if penetration <= 0
      return
    end

    @particle_movement = Array.new(2)

    total_i_mass = @particles[0].inverse_mass
    if @particles[1]
      total_i_mass += @particles[1].inverse_mass
    end

    if total_i_mass <= 0
      return
    end

    move_per_i_mass = contact_normal * (penetration / total_i_mass)
    @particle_movement[0] = move_per_i_mass * @particles[0].inverse_mass

    if @particles[1]
      @particle_movement[1] = move_per_i_mass * -@particles[1].inverse_mass
    end

    @particles[0].position.add!(particle_movement[0])

    if @particles[1]
      @particles[1].position.add!(particle_movement[1])
    end
  end
end