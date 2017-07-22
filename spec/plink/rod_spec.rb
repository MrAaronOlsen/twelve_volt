require 'spec_helper'

RSpec.describe PLink::Rod do

  describe '.initialize' do

    it 'is a PlinkRod' do
      rod = PLink::Rod.new(Particle.new, Particle.new, 10)

      expect(rod).to be_a(PLink::Rod)
    end

    it 'has attributes' do
      p1 = Particle.new
      p2 = Particle.new

      rod = PLink::Rod.new(p1, p2, 10)

      expect(rod.p1).to eq(p1)
      expect(rod.p2).to eq(p2)
      expect(rod.length).to eq(10)
    end

    it 'attributes can be written' do
      p1 = Particle.new
      p2 = Particle.new

      rod = PLink::Rod.new(p1, p2, 10)

      rod.length = (15)

      expect(rod.length).to eq(15)
    end

    it 'attributes can not be written' do
      p1 = Particle.new
      p2 = Particle.new

      rod = PLink::Rod.new(p1, p2, 10)

      expect { rod.p1 = Particle.new }.to raise_error(NoMethodError)
      expect { rod.p2 = Particle.new }.to raise_error(NoMethodError)
    end
  end

  describe '.add_contact' do

    it 'will return false if not over extended' do
      p1 = Particle.new
      p2 = Particle.new

      p1.position = Vector.new(10, 0)
      p2.position = Vector.new(5, 0)

      rod = PLink::Rod.new(p1, p2, 5)

      expect(rod.add_contact).to be_falsey
    end

    it 'will return a contact if over extended' do
      p1 = Particle.new
      p2 = Particle.new

      p1.position = Vector.new(10, 0)
      p2.position = Vector.new(5, 0)

      rod = PLink::Rod.new(p1, p2, 4)
      contact = rod.add_contact

      expect(contact).to be_a(PContact)
      expect(contact.penetration).to eq(-1)
      expect_vector(-1, 0, contact.contact_normal)
    end

    it 'will return a contact if over under extended' do
      p1 = Particle.new
      p2 = Particle.new

      p1.position = Vector.new(10, 0)
      p2.position = Vector.new(5, 0)

      rod = PLink::Rod.new(p1, p2, 6)
      contact = rod.add_contact

      expect(contact).to be_a(PContact)
      expect(contact.penetration).to eq(1)
      expect_vector(1, 0, contact.contact_normal)
    end
  end
end