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
end