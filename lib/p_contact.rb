class PContact

  def initialize(particle1, particle2, restitution, contact_normal)
    @particle = { first: particle1, second: particle2 }
    @restitution = restitution
    @contact_normal = contact_normal
    @penetration = penetration
  end

  def resolve(duration)
    resolve_velocity(duration)
    resolve_interpenetration(duration)
  end

  def calculate_seperating_velocity
    relative_velocity = @particle[:first].velocity.copy

    if @particle[:second]
      relative_velocity.sub!(@particle[:second].velocity)
      relative_velocity * @contact_normal
    end
  end

  private

  def resolve_velocity(duration)
    seperating_velocity = calculate_seperating_velocity

    return if seperating_velocity > 0

    new_seperating_velocity = seperating_velocity.inverse * restitution
    delta_velocity = new_seperating_velocity - seperating_velocity

    total_i_mass = particle[:first].inverse_mass
    total_i_mass.add!(particle[:second].inverse_mass) if @particle[:second]

    return if total_inverse_mass <= 0

    impulse = delta_velocity / total_i_mass
    impulse_per_i_mass = @contact_normal * impulse

    particle[:first].velocity.add!( impulse_per_i_mass * particle[:first].inverse_mass )

    if particle[:second]
      particle[:second].velocity.add!( impulse_per_i_mass * -particle[:second].inverse_mass )
    end
  end

  def resolve_interpenetration(duration)
    return if @penetration <= 0

    total_i_mass = particle[:first].inverse_mass
    total_i_mass.add!(particle[:second].inverse_mass) if particle[:second]

    return if total_i_mass <= 0

    move_per_i_mass = @contact_normal * (@penetration / total_i_mass)

    p_mov_first = move_per_i_mass * particle[:first].inverse_mass
    p_mov_sec = move_per_i_mass * particle[:second].inverse_mass if particle[:second]

    particle[:first].position.add!(p_mov_first)
    particle[:second].position.add!(p_mov_sec) if particle[:second]
  end
end