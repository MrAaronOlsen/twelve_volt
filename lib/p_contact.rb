class PContact

  def initialize(particle1, particle2, restitution, contact_normal)
    @particle = [ first: particle1, second: particle2 ]
    @restitution = restitution
    @contact_normal = contact_normal
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

  def resolve_velocity(duration)
    seperating_velocity = calculate_seperating_velocity

    unless seperating_velocity > 0
      new_seperating_velocity = seperating_velocity * restitution

end