class PContactResolver
  attr_accessor :iterations
  attr_reader :iterations_used

  def initialize
    @iterations = 0;
    @iterations_used = 0;
  end

  def resolve_contacts(*contacts, duration)
    contacts.flatten!
    @iterations_used = 0

    max = 0;
    max_index = contacts.count

    while iterations_used < iterations do

      contacts.each do |contact|
        sep_velocity = contact.get_seperating_velocity

        if sep_velocity < max && (sep_velocity < 0 || contact.penetration > 0)
          max = sep_velocity
          max_index = contacts.find_index(contact)
        end
      end

      break if max_index == contacts.count

      contacts[max_index].resolve(duration)
      @iterations_used += 1
    end
  end
end