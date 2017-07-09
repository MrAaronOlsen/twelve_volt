class PForceRegistry
  attr_reader :registry

  def initialize
    @registry = []
  end

  def add(particle, pfgen)
    @registry << Pair.new(particle, pfgen)
  end

  def remove(particle, pfgen)
    @registry.reject! do |pair|
      pair.particle == particle && pair.pfgen == pfgen
    end
  end

  def clear
    @registry = []
  end

  def update(duration)
    @registry.each { |pair| pair.update(duration) }
  end

  class Pair
    attr_reader :particle, :pfgen

    def initialize(particle, pfgen)
      @particle = particle
      @pfgen = pfgen
    end

    def update(duration)
      @pfgen.update(@particle, duration)
    end
  end
end