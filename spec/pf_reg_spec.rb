require 'spec_helper'

RSpec.describe PForceRegistry do

  before do
    @pfreg = PForceRegistry.new
  end

  describe 'Initialize' do

    it 'is a pfreg' do
      expect(@pfreg).to be_a(PForceRegistry)
    end

    it 'has default attributes' do
      expect(@pfreg.registry).to eq([])
    end

  end

  describe 'Pairs' do

    describe 'Initialize' do

      it 'is a pair' do
        pair = PForceRegistry::Pair.new(Particle.new, PForceGenerator.new)

        expect(pair).to be_a (PForceRegistry::Pair)
      end

      it 'has attributes' do
        particle = Particle.new
        pfgen = PForceGenerator.new
        pair = PForceRegistry::Pair.new(particle, pfgen)

        expect(pair.particle).to eq(particle)
        expect(pair.pfgen).to eq(pfgen)
      end
    end

    describe 'behaviour' do

      it 'one instance of pfgen can be used for multiple pairs' do
        particle1 = Particle.new
        particle2 = Particle.new
        pfgen = PForceGenerator.new

        pair1 = PForceRegistry::Pair.new(particle1, pfgen)
        pair2 = PForceRegistry::Pair.new(particle2, pfgen)

        expect(pair1.particle).to eq(particle1)
        expect(pair1.pfgen).to eq(pfgen)

        expect(pair2.particle).to eq(particle2)
        expect(pair2.pfgen).to eq(pfgen)
      end

      it 'can update pfgen' do
        pfgen = PForceGenerator.new.gravity(Vector.new(0, 10))
        particle = Particle.new
        particle.mass = 10
        pair = PForceRegistry::Pair.new(particle, pfgen)

        new_force = Vector.new(0, 100)

        pair.update(0.001)

        assert_vectors_are_equal(particle.forces, new_force)
      end
    end
  end

  describe 'Constructors' do

    before do
      @particle = Particle.new
      @pfgen = PForceGenerator.new
      @registry = PForceRegistry.new
    end

    it 'can add pairs to registry' do
      @registry.add(@particle, @pfgen)

      expect(@registry.registry.count).to eq(1)
      expect(@registry.registry.first).to be_a(PForceRegistry::Pair)
      expect(@registry.registry.first.particle).to eq(@particle)
      expect(@registry.registry.first.pfgen).to eq(@pfgen)
    end

    it 'can remove a pair from registry' do
      @registry.add(@particle, @pfgen)

      @registry.remove(@particle, @pfgen)
      expect(@registry.registry.empty?).to be_truthy
    end

    it 'returns nil if it cant find pair to remove' do
      particle = Particle.new
      @registry.add(@particle, @pfgen)

      result = @registry.remove(particle, @pfgen)
      expect(@registry.registry.empty?).to be_falsey
      expect(result).to be_falsey
    end

    it 'can clear the registry' do
      3.times { @registry.add(@particle, @pfgen) }

      expect(@registry.registry.count).to eq(3)
      @registry.clear

      expect(@registry.registry.empty?).to be_truthy
    end

    it 'can update pairs' do
      @particle.mass = 10
      @pfgen.gravity(Vector.new(0, 10))

      @registry.add(@particle, @pfgen)
      @registry.update(0.001)

      new_force = Vector.new(0, 100)

      assert_vectors_are_equal(@particle.forces, new_force)
    end
  end
end