class PLink
  attr_reader :p1, :p2

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end

  def current_length
    (p1 - p2).magnitude
  end

  class << self

    def p_cable(p1, p2, max_length, restitution)
      plink = Plink.new(p1, p2)

      length = plink.current_length

      return 0 if length < max_length

      pcon = PContact.new(p1, p2)
      pcon.contact_normal = PContact.contact_normal(p2, p1)
      pcon.penetration = length - max_length
      pcon.restitution = restitution

      return 1
    end

    def p_rod(p1, p2, rod_length)
      plink = PLink.new(p1, p2)

      length = plink.current_length
      return 0 if length == rod_length

      pcon = Pcontact.new(p1, p2)
      contact_normal = PContact.contact_normal(p2, p1)

      if length > rod_length
        plink.contact_normal = contact_normal
        plink.penetration = rod_length - length
      else
        plink.contact_normal = contact_normal * -1
        plink.penetration = length - rod_length
      end

      return 1
    end
  end
end

