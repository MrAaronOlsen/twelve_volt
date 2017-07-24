require 'spec_helper'

RSpec.describe PContactResolver do

  describe 'example test' do
    p1 = Particle.new
    p1.position = Vector.new(2, 2)
    p1.velocity = Vector.new(1, 0)
    p2 = Particle.new
    p2.position = Vector.new(4, 3)
    p2.velocity = Vector.new(-2, 2)
    p3 = Particle.new
    p3.position = Vector.new(5, 6)
    p3.velocity = Vector.new(-1, -1)
    p4 = Particle.new
    p4.position = Vector.new(2, 7)
    p4.velocity = Vector.new(1, -1)

    [p1, p2, p3, p4].each { |particle| particle.mass = 10 }

    pcon1 = PContact.new(p1, p2)
    pcon1.contact_normal = PContact.contact_normal(p1, p2)
    pcon1.penetration = 1
    pcon1.restitution = 1
    pcon2 = PContact.new(p2, p3)
    pcon2.contact_normal = PContact.contact_normal(p2, p3)
    pcon2.penetration = 1
    pcon2.restitution = 1

    pcons = [pcon1, pcon2]

    pcon_res = PContactResolver.new
    pcon_res.iterations = pcons.length * 2
    pcon_res.resolve_contacts(pcons, 1.0)
  end

  xdescribe '.resolve_contacts' do

    it 'can resolve contacts in order of greatest seperating velocity' do
      p1 = Particle.new
      p1.position = Vector.new(11, 4)
      p1.velocity = Vector.new(-1, 0)
      p2 = Particle.new
      p2.position = Vector.new(8, 4)
      p2.velocity = Vector.new(-3, 3)
      p3 = Particle.new
      p3.position = Vector.new(5, 7)
      p3.velocity = Vector.new(2, 0)
      p4 = Particle.new
      p4.position = Vector.new(2, 7)
      p4.velocity = Vector.new(0, 3)

      [p1, p2, p3, p4].each { |particle| particle.mass = 10 }

      pcon1 = PContact.new(p1, p2)
      pcon1.contact_normal = PContact.contact_normal(p1, p2)
      pcon1.penetration = 1
      pcon1.restitution = 1
      pcon2 = PContact.new(p2, p3)
      pcon2.contact_normal = PContact.contact_normal(p2, p3)
      pcon2.penetration = 1
      pcon2.restitution = 1

      pcons = [pcon1, pcon2]

      pcon_res = PContactResolver.new
      pcon_res.iterations = pcons.length * 2
      pcon_res.resolve_contacts(pcons, 1.0)

      expect_vector(11, 4, p1.position)
      expect_vector(-1, 0, p1.velocity)
      expect_vector(9.414213562373092, 2.585786437626904, p2.position)
      expect_vector(1.0000000000000009, -1.0000000000000009, p2.velocity)
      expect_vector(3.585786437626904, 8.414213562373094, p3.position)
      expect_vector(-2.000000000000001, 4.000000000000001, p3.velocity)
      expect_vector(2, 7, p4.position)
      expect_vector(0, 3, p4.velocity)

      pcon1 = PContact.new(p1, p2)
      pcon1.contact_normal = PContact.contact_normal(p1, p2)
      pcon1.penetration = 2.5
      pcon1.restitution = 1
      pcon2 = PContact.new(p3, p4)
      pcon2.contact_normal = PContact.contact_normal(p3, p4)
      pcon2.penetration = 1.5
      pcon2.restitution = 1

      pcons = [pcon1, pcon2]
      pcon_res.iterations = pcons.length * 2
      pcon_res.resolve_contacts(pcons, 1.0)

      pcon_res.resolve_contacts(pcons, 1.0)

      expect_vector(14.731636731206763, 7.327895326825729, p1.position)
      expect_vector(-0.3827308420724508, 0.5504842228831962, p1.velocity)
      expect_vector(5.682576831166332, -0.7421088891988248, p2.position)
      expect_vector(0.38273084207245167, -1.5504842228831972, p2.velocity)
      expect_vector(5.824768476350961, 10.410950758468532, p3.position)
      expect_vector(-1.3827308420724527, 4.550484222883197, p3.velocity)
      expect_vector(-0.23898203872405543, 5.003262803904562, p4.position)
      expect_vector(-0.6172691579275483, 2.449515777116804, p4.velocity)
    end
  end
end