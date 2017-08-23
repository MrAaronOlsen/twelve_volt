class PForceRegistry
  attr_reader :registry

  def initialize
    @registry = []
  end

  def add(particle, pf_gen)
    @registry << Pair.new(particle, pf_gen)
  end

  def remove(particle, pf_gen)
    @registry.reject! do |pair|
      pair.particle == particle && pair.pf_gen == pf_gen
    end
  end

  def clear
    @registry = []
  end

  def update(duration)
    @registry.each { |pair| pair.update(duration) }
  end

  class Pair
    attr_reader :particle, :pf_gen

    def initialize(particle, pf_gen)
      @particle = particle
      @pf_gen = pf_gen
    end

    def update(duration)
      @pf_gen.update(@particle, duration)
    end
  end
end