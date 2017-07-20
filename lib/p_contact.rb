class PContact
  attr_accessor :restitution, :contact_normal, :penetration
  attr_reader :particles

  def initialize(*particles)
    @particles = { first: particles[0], second: particles[1] }
  end

  def resolve(duration)
    resolve_velocity(duration)
    # resolve_interpenetration(duration)
  end

  def get_seperating_velocity
    rel_velocity = @particles[:first].velocity.copy

    rel_velocity.tap do |rel_v|
      rel_v.sub!(@particles[:second].velocity) if @particles[:second]
      rel_v.mult!(contact_normal)
    end
  end

  class << self
    def contact_normal(*particles)
      contact = particles[1].position - particles[0].position
      contact.normalize!
    end

    # def calculate_penetration(*particles)
    #   not sure if I need this yet
    # end
  end

  private

  def resolve_velocity(duration)
    seperating_velocity = get_seperating_velocity

    return if seperating_velocity > 0.0

    new_sep_velocity = seperating_velocity.inverse * restitution
    delta_velocity = new_sep_velocity - seperating_velocity

    total_i_mass = @particles[:first].inverse_mass
    total_i_mass += @particles[:second].inverse_mass if @particles[:second]

    return if total_i_mass <= 0.0

    impulse = delta_velocity / total_i_mass
    impulse_per_i_mass = contact_normal.mult(impulse)

    @particles[:first].velocity.add!( impulse_per_i_mass * @particles[:first].inverse_mass )

    if @particles[:second]
      @particles[:second].velocity.add!( impulse_per_i_mass * -@particles[:second].inverse_mass )
    end
  end

  def resolve_interpenetration(duration)
    return if penetration <= 0

    total_i_mass = @particles[:first].inverse_mass
    total_i_mass.add!(@particles[:second].inverse_mass) if @particles[:second]

    return if total_i_mass <= 0

    move_per_i_mass = contact_normal * (penetration / total_i_mass)

    p_mov_first = move_per_i_mass * @particles[:first].inverse_mass
    p_mov_sec = move_per_i_mass * @particles[:second].inverse_mass if @particles[:second]

    @particles[:first].position.add!(p_mov_first)
    @particles[:second].position.add!(p_mov_sec) if particles[:second]
  end
end