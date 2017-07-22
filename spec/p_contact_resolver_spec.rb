require 'spec_helper'

RSpec.describe PContactResolver do

  xdescribe 'Initialize' do

    it 'is a PContactResolver' do
      expect(PContactResolver.new).to be_a(PContactResolver)
    end

    it 'has default attributes' do
      pcon_resolver = PContactResolver.new

      expect(pcon_resolver.iterations).to eq(0)
      expect(pcon_resolver.iterations_used).to eq(0)
    end

    it 'attributes can be assigned' do
      pcon_resolver = PContactResolver.new
      pcon_resolver.iterations = 10

      expect(pcon_resolver.iterations).to eq(10)
    end

    it 'attributes can not be assigned' do
      pcon_resolver = PContactResolver.new

      expect { pcon_resolver.iterations_used = 10 }.to raise_error(NoMethodError)
    end
  end

  describe '.resolve_contacts' do

    it 'can resolve contacts in order of greatest seperating velocity' do
      p1 = Particle.new
      p1.position = Vector.new(4, 4)
      p1.velocity = Vector.new(2, 2)
      p2 = Particle.new
      p2.position = Vector.new(8, 4)
      p2.velocity = Vector.new(-3, 3)
      p3 = Particle.new
      p3.position = Vector.new(8, 8)
      p3.velocity = Vector.new(-1, -1)
      p4 = Particle.new
      p4.position = Vector.new(4, 8)
      p4.velocity = Vector.new(4, -4)

      [p1, p2, p3, p4].each { |part| part.mass = 10 }

      pcon1 = PContact.new(p1, p2)
      pcon1.contact_normal = PContact.contact_normal(p1, p2)
      pcon2 = PContact.new(p2, p3)
      pcon2.contact_normal = PContact.contact_normal(p2, p3)
      pcon3 = PContact.new(p3, p4)
      pcon3.contact_normal = PContact.contact_normal(p3, p4)
      pcon4 = PContact.new(p4, p1)
      pcon4.contact_normal = PContact.contact_normal(p4, p1)
      pcon5 = PContact.new(p1, p3)
      pcon5.contact_normal = PContact.contact_normal(p1, p3)
      pcon6 = PContact.new(p2, p4)
      pcon6.contact_normal = PContact.contact_normal(p2, p4)

      pcons = [pcon1, pcon2, pcon3, pcon4, pcon5, pcon6]
      pcons.each do |pcon|
        pcon.penetration = 1
        pcon.restitution = 1
      end

      sep_vs = pcons.map { |pcon| pcon.get_seperating_velocity }

      binding.pry
    end
  end
end