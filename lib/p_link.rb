class PLink
  attr_reader :p1, :p2, :parts

  def current_length
    (p1.position - p2.position).magnitude
  end

  class Cable < PLink
    attr_accessor :max_length, :restitution

    def initialize(p1, p2, max_length, restitution)
      @p1 = p1
      @p2 = p2
      @parts = [@p1, @p2]
      @max_length = max_length
      @restitution = restitution
    end

    def add_contact
      return false if current_length < max_length

      pcon = PContact.new(p1, p2)
      pcon.tap do
        pcon.contact_normal = PContact.contact_normal(p2, p1)
        pcon.penetration = current_length - max_length
        pcon.restitution = restitution
      end
    end
  end

  class Rod < PLink
    attr_accessor :length

    def initialize(p1, p2, length)
      @p1 = p1
      @p2 = p2
      @length = length
    end

    def add_contact
      return false if current_length == length

      pcon = PContact.new(p1, p2)
      pcon.tap do
        contact_normal = PContact.contact_normal(p2, p1)
        pcon.restitution = 0

        if current_length > length
          pcon.contact_normal = contact_normal
          pcon.penetration = length - current_length
        else
          pcon.contact_normal = contact_normal * -1
          pcon.penetration = length - current_length
        end
      end
    end
  end
end

