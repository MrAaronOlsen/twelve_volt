class PWorld
  attr_accessor :particles, :p_links, :pcons, :pcon_resolver

  def initialize
    @particles = []
    @p_links = []
    @pcon_resolver = PContactResolver.new
  end

  def start_frame
    @particles.each { |particle| particle.clear_forces }
  end

  def update(duration)
    integrate(duration)
    generate_contacts(duration)
  end

  def generate_contacts(duration)
    contacts = @p_links.map { |plink| plink.add_contact }
    contacts.delete(false)

    @pcon_resolver.resolve_contacts(contacts, duration)
  end

  def integrate(duration)
    particles.each do |particle|
      particle.integrate(duration)
    end
  end
end