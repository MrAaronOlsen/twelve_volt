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
      expect(PContact.new).to be_a(PContact)
    end

    it 'can have null particles' do
      pcon = PContact.new

      expect(pcon.particles[:first]).to be_nil
      expect(pcon.particles[:second]).to be_nil
    end

    it 'can have particles' do
      pcon = PContact.new(@particle1, @particle2)

      expect(pcon.particles[:first]).to eq(@particle1)
      expect(pcon.particles[:second]).to eq(@particle2)
    end

    it 'can have null attributes' do
      pcon = PContact.new

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
      @particle1.velocity = Vector.new(-2, 2)
      @particle1.position = Vector.new(6, 2)
      @particle2 = Particle.new
      @particle2.velocity = Vector.new(2, -2)
      @particle2.position = Vector.new(1, 7)

      @pcon = PContact.new(@particle1, @particle2)
    end

    describe 'Helper calculations' do

      it 'can calculate contact normal' do
        contact_normal = PContact.contact_normal(@particle1, @particle2)

        result = Vector.new(-0.7071067811865475, 0.7071067811865475)
        assert_vectors_are_equal(contact_normal, result)
      end
    end

    it 'can calculate seperating velocity of two particles' do
      @pcon.contact_normal = PContact.contact_normal(@particle1, @particle2)
      seperating_velocity = @pcon.seperating_velocity

      result = Vector.new(2.82842712474619, 2.82842712474619)
      assert_vectors_are_equal(result, seperating_velocity)
    end

    it 'can calculate seperating velocity for one particle' do
      pcon = PContact.new(@particle1)
      anchor = @particle2
      pcon.contact_normal = PContact.contact_normal(anchor, @particle1)

      seperating_velocity = pcon.seperating_velocity

      result = Vector.new(-1.414213562373095, -1.414213562373095)
      assert_vectors_are_equal(result, seperating_velocity)
    end
  end

  describe 'Resolvers' do
    it 'can resolve velocity' do
    end

    it 'can resolve resolve_interpenetration' do
    end
  end
end