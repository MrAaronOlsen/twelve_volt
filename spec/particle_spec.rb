require 'spec_helper'

RSpec.describe Particle do

  def assert_vectors_are_equal(vector1, vector2)
    expect(vector1.x).to eq(vector2.x)
    expect(vector1.y).to eq(vector2.y)
  end

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
      expect(particle.forces).to eq([])
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

      expect(particle.forces.count).to eq(2)
      expect(particle.forces[0]).to eq(force1)
      expect(particle.forces[1]).to eq(force2)
    end

    it 'can clear forces' do
      particle = Particle.new
      force1 = Vector.new(10, 20)
      force2 = Vector.new(3, 7)

      particle.add_force(force1)
      particle.add_force(force2)
      particle.clear_forces

      expect(particle.forces.empty?).to be_truthy
    end
  end
end