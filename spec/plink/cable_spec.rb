require 'spec_helper'

RSpec.describe PLink::Cable do

  describe '.initialize' do

    it 'is a PlinkCable' do
      cable = PLink::Cable.new(Particle.new, Particle.new, 10, 1)

      expect(cable).to be_a(PLink::Cable)
    end

    it 'has attributes' do
      p1 = Particle.new
      p2 = Particle.new

      cable = PLink::Cable.new(p1, p2, 10, 1)

      expect(cable.p1).to eq(p1)
      expect(cable.p2).to eq(p2)
      expect(cable.length).to eq(10)
      expect(cable.restitution).to eq(1)
    end

    it 'attributes can be written' do
      p1 = Particle.new
      p2 = Particle.new

      cable = PLink::Cable.new(p1, p2, 10, 1)

      cable.length = (15)
      cable.restitution = (0.5)

      expect(cable.length).to eq(15)
      expect(cable.restitution).to eq(0.5)
    end

    it 'attributes can not be written' do
      p1 = Particle.new
      p2 = Particle.new

      cable = PLink::Cable.new(p1, p2, 10, 1)

      expect { cable.p1 = Particle.new }.to raise_error(NoMethodError)
      expect { cable.p2 = Particle.new }.to raise_error(NoMethodError)
    end
  end

  describe '.add_contact' do

    it 'will return false if not over extended' do
      p1 = Particle.new
      p2 = Particle.new

      p1.position = Vector.new(10, 0)
      p2.position = Vector.new(5, 0)

      cable = PLink::Cable.new(p1, p2, 10, 1)

      expect(cable.add_contact).to be_falsey
    end

    it 'will return a contact if over extended' do
      p1 = Particle.new
      p2 = Particle.new

      p1.position = Vector.new(11, 0)
      p2.position = Vector.new(0, 0)

      cable = PLink::Cable.new(p1, p2, 10, 1)
      contact = cable.add_contact

      expect(contact).to be_a(PContact)
      expect(contact.penetration).to eq(1)
      expect_vector(-1, 0, contact.contact_normal)
    end
  end
end