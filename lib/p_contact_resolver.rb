class PContactResolver
  attr_accessor :iterations

  def initialize
    @iterations = 0;
  end

  def resolve_contacts(*contacts, duration)
    contacts.flatten!
    iterations = (contacts.count * 2)

    iterations.times do |i|

      break if contacts.all? { |contact| contact.get_seperating_velocity >= 0 }

      contact = contacts.min_by { |contact| contact.get_seperating_velocity }
      sep_velocity = contact.get_seperating_velocity

      if sep_velocity < 0 || contact.penetration > 0
        contact.resolve(duration)
      end

      move = contact.particle_movement

      if move
        contacts.each do |j_contact|
          if j_contact.particles[0] == contact.particles[0]
            contact.penetration -= move[0].dot(j_contact.contact_normal)
          elsif j_contact.particles[0] == contact.particles[1]
            contact.penetration -= move[1].dot(j_contact.contact_normal)
          end

          if j_contact.particles[1]
            if j_contact.particles[1] == contact.particles[0]
              contact.penetration -= move[0].dot(j_contact.contact_normal)
            elsif j_contact.particles[1] == contact.particles[1]
              contact.penetration -= move[1].dot(j_contact.contact_normal)
            end
          end
        end
      end
    end
  end
end