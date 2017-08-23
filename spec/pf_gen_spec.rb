require 'spec_helper'

RSpec.describe PForceGenerator do

  before do
    @pfgen = PForceGenerator.new
  end

  describe 'Initialize' do
    it 'is a PForceGenerator' do
      expect(@pfgen).to be_a(PForceGenerator)
    end

    it 'has no attributes' do
      expect(@pfgen.force).to be_falsey
    end
  end

  describe 'Forces' do
    describe 'Gravity' do

      it 'can be gravity' do
        @pfgen.gravity(Vector.new(0, 10))

        expect(@pfgen.force).to be_a(PForceGenerator::Gravity)
      end

      it 'can add gravity force to particle' do
        particle = Particle.new
        particle.mass = 10

        @pfgen.gravity(Vector.new(0, 10))
        @pfgen.update(particle, 0.001)

        new_force = Vector.new(0, 100)
        assert_vectors_are_equal(particle.forces, new_force)
      end
    end

    describe 'drag' do

      it 'can be drag' do
        @pfgen.drag(2.0)

        expect(@pfgen.force).to be_a(PForceGenerator::Drag)
      end

      it 'can add drag force to particle' do
        particle = Particle.new
        particle.mass = 10
        particle.velocity = Vector.new(10, 100)

        @pfgen.drag(2.0)
        @pfgen.update(particle, 1.0)

        new_force = Vector.new(-4039.950248448356, -40399.50248448356)
        assert_vectors_are_equal(particle.forces, new_force)
      end
    end
  end
end
