class PLink
  attr_accessor :length, :restitution
  attr_reader :p1, :p2, :parts

  def current_length
    (p1.position - p2.position).magnitude
  end

  class Cable < PLink

    def initialize(p1, p2, length, restitution)
      @p1 = p1
      @p2 = p2
      @parts = [@p1, @p2]
      @length = length
      @restitution = restitution
    end

    def add_contact
      return false if current_length < length

      pcon = PContact.new(p1, p2)
      pcon.tap do
        pcon.contact_normal = (p2.position - p1.position).unit
        pcon.penetration = current_length - length
        pcon.restitution = restitution
      end
    end
  end

  class Rod < PLink

    def initialize(p1, p2, length)
      @p1 = p1
      @p2 = p2
      @length = length
    end

    def add_contact
      return false if current_length == length

      pcon = PContact.new(p1, p2)

      pcon.tap do
        contact_normal = (p2.position - p1.position).unit
        pcon.restitution = 0

        if current_length > length
          pcon.contact_normal = contact_normal
          pcon.penetration = current_length - length
        else
          pcon.contact_normal = contact_normal * -1
          pcon.penetration = current_length - length
        end
      end
    end
  end
end

