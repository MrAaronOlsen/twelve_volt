class PForceRegistry

  def initialize
    @registry = []
  end

  def add(particle, pfgen)
    @registry << Pair.new(particle, pfgen)
  end

  def remove(particle, pfgen)
    @registry.delete_if do |pair|
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
    def initialize(particle, pfgen)
      @particle = particle
      @pfgen = pfgen
    end

    def update(duration)
      @pfgen.update(@particle, duration)
    end
  end
end