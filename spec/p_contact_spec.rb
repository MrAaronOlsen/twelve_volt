require 'spec_helper'

RSpec.describe PContact do

  before do
    @particle1 = Particle.new
    @particle1.position = Vector.new(100, 100)
    @particle1.velocity = Vector.new(-10, 0)
    @particle1.mass = 10
    @particle2 = Particle.new
    @particle2.position = Vector.new(110, 100)
    @particle2.velocity = Vector.new(10, 0)
    @particle2.mass = 10
  end

  describe 'Initialize' do

    it 'is a PContact' do
      expect(PContact.new(@particle1, @particle2)).to be_a(PContact)
    end

    it 'will make second particle null' do
      pcon = PContact.new(@particle1)

      expect(pcon.particles[0]).to equal(@particle1)
      expect(pcon.particles[1]).to be_nil
    end

    it 'can have null attributes' do
      pcon = PContact.new(@particle1, @particle2)

      expect(pcon.restitution).to be_nil
      expect(pcon.contact_normal).to be_nil
      expect(pcon.penetration).to be_nil
    end

    it 'attributes can be assigned' do
      pcon = PContact.new(@particle1, @particle2)
      c_normal = Vector.new(10, 10)

      pcon.restitution = 0.2
      pcon.contact_normal = c_normal
      pcon.penetration = 13

      expect(pcon.restitution).to eq(0.2)
      expect(pcon.contact_normal).to eq(c_normal)
      expect(pcon.penetration).to eq(13)
    end
  end

  describe 'Calculations' do

    before do
      @particle1 = Particle.new
      @particle1.position = Vector.new(4.0, 4.0)
      @particle1.velocity = Vector.new(-2.0, -2.0)

      @particle2 = Particle.new
      @particle2.position = Vector.new(0.0, 4.0)
      @particle2.velocity = Vector.new(2.0, -2.0)

      @pcon = PContact.new(@particle1, @particle2)
    end

    describe '.contact_normal' do

      it 'can calculate seperating velocity of two particles' do
        @pcon.contact_normal = (@particle1.position - @particle2.position).unit
        seperating_velocity = @pcon.get_seperating_velocity

        expect(seperating_velocity).to eq(-4.0)
      end
    end
  end

  xdescribe 'Resolvers' do

    before do
      @particle1 = Particle.new
      @particle1.acceleration = Vector.new(1.0, -1.0)
      @particle1.mass = 10.0

      @particle2 = Particle.new
      @particle1.acceleration = Vector.new(1.0, 1.0)
      @particle2.mass = 10.0

      @pcon = PContact.new(@particle1, @particle2)
      @pcon.restitution = 1.0
    end

    it 'will resolve velocity of particles moving towards each other' do
      @particle1.position = Vector.new(4.0, 4.0)
      @particle1.velocity = Vector.new(-2.0, -2.0)

      @particle2.position = Vector.new(0.0, 4.0)
      @particle2.velocity = Vector.new(2.0, -2.0)

      @pcon.contact_normal = PContact.contact_normal = (@particle2.position - @particle1.position).unit
      @pcon.penetration = 0.0 # skips interpenetration
      @pcon.resolve(1.0)

      expect_vector(2.0, -2.0, @pcon.particles[:first].velocity)
      expect_vector(-2.0, -2.0, @pcon.particles[:second].velocity)
    end

    it 'will not resolve velocity of particles moving apart' do
      @particle1.position = Vector.new(4.0, 4.0)
      @particle1.velocity = Vector.new(2.0, 2.0)

      @particle2.position = Vector.new(0.0, 0.0)
      @particle2.velocity = Vector.new(-2.0, -2.0)

      @pcon.contact_normal = PContact.contact_normal(@particle1, @particle2)
      @pcon.penetration = 0.0 # skips interpenetration
      @pcon.resolve(1.0)

      expect_vector(2.0, 2.0, @pcon.particles[:first].velocity)
      expect_vector(-2.0, -2.0, @pcon.particles[:second].velocity)
    end

    it 'can resolve interpenetration' do
      @particle1.position = Vector.new(4.0, 2.0)
      @particle1.velocity = Vector.new(-2.0, 0.0)

      @particle2.position = Vector.new(0.0, 2.0)
      @particle2.velocity = Vector.new(2.0, 0.0)

      @pcon.contact_normal = PContact.contact_normal(@particle1, @particle2)

      @pcon.penetration = 2.0 # hits interpenetration
      @pcon.resolve(1.0)

      expect_vector(5.0, 2.0, @pcon.particles[:first].position)
      expect_vector(-1.0, 2.0, @pcon.particles[:second].position)
    end

    it 'can resolve interpenetration with resting particles' do
      @particle1.position = Vector.new(4.0, 2.0)
      @particle1.velocity = Vector.new(0.0, 1.0)
      @particle1.acceleration = Vector.new(0.0, 1.0)

      @particle2.position = Vector.new(4.0, 4.0)
      @particle2.mass = 0

      @pcon.contact_normal = PContact.contact_normal(@particle1, @particle2)

      @pcon.penetration = 1.0 # hits interpenetration
      @pcon.resolve(1.0)

      expect_vector(4.0, 1.0, @pcon.particles[:first].position)
      expect_vector(0.0, 0.0, @pcon.particles[:first].velocity)
    end

    it 'will not resolve a particle with 0 mass' do
      @particle1.position = Vector.new(4.0, 4.0)
      @particle1.velocity = Vector.new(-2.0, -2.0)

      @particle2.position = Vector.new(4.0, 4.0)
      @particle2.velocity = Vector.new(0.0, 0.0)
      @particle2.mass = 0

      @pcon.contact_normal = PContact.contact_normal(@particle1, @particle2)
      @pcon.penetration = 0.0 # skips interpenetration
      @pcon.resolve(1.0)

      expect_vector(4.0, 4.0, @pcon.particles[:second].position)
      expect_vector(0.0, 0.0, @pcon.particles[:second].velocity)
    end

    it 'will skip resolution if both particles have 0 mass' do
      @particle1.position = Vector.new(4.0, 6.0)
      @particle1.velocity = Vector.new(0.0, 0.0)
      @particle1.mass = 0

      @particle2.position = Vector.new(5.0, 7.0)
      @particle2.velocity = Vector.new(0.0, 0.0)
      @particle2.mass = 0

      @pcon.contact_normal = PContact.contact_normal(@particle1, @particle2)
      @pcon.penetration = 1.0
      @pcon.resolve(1.0)

      expect_vector(4.0, 6.0, @pcon.particles[:first].position)
      expect_vector(0.0, 0.0, @pcon.particles[:first].velocity)

      expect_vector(5.0, 7.0, @pcon.particles[:second].position)
      expect_vector(0.0, 0.0, @pcon.particles[:second].velocity)
    end
  end
end