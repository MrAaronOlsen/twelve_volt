require 'spec_helper'

RSpec.describe PForceRegistry do

  before do
    @pf_reg = PForceRegistry.new
  end

  describe '.initialize' do

    it 'is a PForceRegistry' do
      expect(@pf_reg).to be_a(PForceRegistry)
    end

    it 'has default attributes' do
      expect(@pf_reg.registry).to eq([])
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
        pf_gen = PForceGenerator.new
        pair = PForceRegistry::Pair.new(particle, pf_gen)

        expect(pair.particle).to eq(particle)
        expect(pair.pf_gen).to eq(pf_gen)
      end
    end

    describe 'behaviour' do

      it 'one instance of pf_gen can be used for multiple pairs' do
        particle1 = Particle.new
        particle2 = Particle.new
        pf_gen = PForceGenerator.new

        pair1 = PForceRegistry::Pair.new(particle1, pf_gen)
        pair2 = PForceRegistry::Pair.new(particle2, pf_gen)

        expect(pair1.particle).to eq(particle1)
        expect(pair1.pf_gen).to eq(pf_gen)

        expect(pair2.particle).to eq(particle2)
        expect(pair2.pf_gen).to eq(pf_gen)
      end

      it 'can update pf_gen' do
        pf_gen = PForceGenerator.new.gravity(Vector.new(0, 10))
        particle = Particle.new
        particle.mass = 10
        pair = PForceRegistry::Pair.new(particle, pf_gen)

        new_force = Vector.new(0, 100)

        pair.update(0.001)

        assert_vectors_are_equal(particle.forces, new_force)
      end
    end
  end

  describe 'Constructors' do

    before do
      @particle = Particle.new
      @pf_gen = PForceGenerator.new
      @registry = PForceRegistry.new
    end

    it 'can add pairs to registry' do
      @registry.add(@particle, @pf_gen)

      expect(@registry.registry.count).to eq(1)
      expect(@registry.registry.first).to be_a(PForceRegistry::Pair)
      expect(@registry.registry.first.particle).to eq(@particle)
      expect(@registry.registry.first.pf_gen).to eq(@pf_gen)
    end

    it 'can remove a pair from registry' do
      @registry.add(@particle, @pf_gen)

      @registry.remove(@particle, @pf_gen)
      expect(@registry.registry.empty?).to be_truthy
    end

    it 'returns nil if it cant find pair to remove' do
      particle = Particle.new
      @registry.add(@particle, @pf_gen)

      result = @registry.remove(particle, @pf_gen)
      expect(@registry.registry.empty?).to be_falsey
      expect(result).to be_falsey
    end

    it 'can clear the registry' do
      3.times { @registry.add(@particle, @pf_gen) }

      expect(@registry.registry.count).to eq(3)
      @registry.clear

      expect(@registry.registry.empty?).to be_truthy
    end

    it 'can update pairs' do
      @particle.mass = 10
      @pf_gen.gravity(Vector.new(0, 10))

      @registry.add(@particle, @pf_gen)
      @registry.update(0.001)

      new_force = Vector.new(0, 100)

      assert_vectors_are_equal(@particle.forces, new_force)
    end
  end
end