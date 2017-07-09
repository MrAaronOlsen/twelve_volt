require 'spec_helper'

RSpec.describe Particle do

  describe 'Initialize' do

    it 'is a particle' do
      expect(Particle.new).to be_a_kind_of(Particle)
    end

    it 'has default attributes' do
      particle = Particle.new

      assert_vectors_are_equal(Vector.new, particle.position)
      assert_vectors_are_equal(Vector.new, particle.velocity)
      assert_vectors_are_equal(Vector.new, particle.acceleration)
      expect(particle.mass).to eq(0)
      expect(particle.inverse_mass).to eq(0)
      expect(particle.damping).to eq(0.999)
      assert_vectors_are_equal(particle.forces, Vector.new)
    end

    it 'can have different attributes' do
      pos = Vector.new(5, 5)
      vel = Vector.new(100, 300)
      acc = Vector.new(0.1, 0.56)

      particle = Particle.new(pos, vel, acc)

      assert_vectors_are_equal(pos, particle.position)
      assert_vectors_are_equal(vel, particle.velocity)
      assert_vectors_are_equal(acc, particle.acceleration)
    end
  end

  describe 'mass' do

    it 'can have mass' do
      particle = Particle.new

      particle.mass = 10

      expect(particle.mass).to eq(10)
      expect(particle.inverse_mass).to eq(0.1)
    end
  end

  describe 'integration' do

    before do
      @particle = Particle.new
      @particle.position = Vector.new(10, 20)
      @particle.velocity = Vector.new(1, 1)
      @particle.acceleration = Vector.new(0, 0)

      @particle.mass = 10
      @particle.damping = 1

      @duration = 2
    end

    it 'wont integrate if mass is 0' do
      @particle.mass = 0
      @particle.integrate(@duration)

      assert_vectors_are_equal(@particle.position, Vector.new(10, 20))
    end

    it 'updates position by velocity' do
      @particle.integrate(@duration)

      new_position = (Vector.new(12, 22))
      assert_vectors_are_equal(@particle.position, new_position)
    end

    it 'updates velocity by acceleration' do
      @particle.velocity = Vector.new(10, 20)
      @particle.acceleration = Vector.new(1, 1)

      @particle.integrate(@duration)

      new_velocity = (Vector.new(12, 22))
      assert_vectors_are_equal(@particle.velocity, new_velocity)
    end

    it 'updates velocity with drag' do
      @particle.velocity = Vector.new(2, 4)
      @particle.damping = 0.5

      new_velocity = (Vector.new(1, 1))

      @particle.integrate(@duration)
      new_velocity = (Vector.new(0.5, 1.0))
      assert_vectors_are_equal(@particle.velocity, new_velocity)
    end
  end

  describe 'forces' do

    it 'can add forces' do
      particle = Particle.new
      force1 = Vector.new(10, 20)
      force2 = Vector.new(3, 7)

      particle.add_force(force1)
      particle.add_force(force2)

      new_force = Vector.new(13, 27)
      assert_vectors_are_equal(particle.forces, new_force)
    end

    it 'can clear forces' do
      particle = Particle.new
      force1 = Vector.new(10, 20)
      force2 = Vector.new(3, 7)

      particle.add_force(force1)
      particle.add_force(force2)
      particle.clear_forces

      new_force = Vector.new
      assert_vectors_are_equal(particle.forces, new_force)
    end
  end
end