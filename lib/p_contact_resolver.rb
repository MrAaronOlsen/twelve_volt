class PContactResolver
  attr_accessor :iterations

  def initialize
    @iterations = 0;
  end

  def resolve_contacts(*contacts, duration)
    contacts.flatten!
    max_index = contacts.count

    iterations.times do |i|
      # max = 0;

      queue = contacts.sort_by { |contact| contact.get_seperating_velocity }
      contact = queue.first
      
      sep_velocity = contact.get_seperating_velocity

      if sep_velocity < 0 || contact.penetration > 0
        contact.resolve(duration)
      end

      # contacts.each_with_index do |contact, i|
      #   if contact
      #     sep_velocity = contact.get_seperating_velocity
      #
      #     if sep_velocity < max && (sep_velocity < 0 || contact.penetration > 0)
      #       max = sep_velocity
      #       max_index = i
      #     end
      #   end
      # end
      #
      # break unless contacts[max_index]
      # contacts[max_index].resolve(duration)
    end
  end
end