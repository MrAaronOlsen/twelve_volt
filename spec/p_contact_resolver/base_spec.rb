require 'spec_helper'

RSpec.describe PContactResolver do

  describe 'Initialize' do

    it 'is a PContactResolver' do
      expect(PContactResolver.new).to be_a(PContactResolver)
    end

    it 'has default attributes' do
      pcon_resolver = PContactResolver.new

      expect(pcon_resolver.iterations).to eq(0)
      expect(pcon_resolver.iterations_used).to eq(0)
    end

    it 'attributes can be assigned' do
      pcon_resolver = PContactResolver.new
      pcon_resolver.iterations = 10

      expect(pcon_resolver.iterations).to eq(10)
    end

    it 'attributes can not be assigned' do
      pcon_resolver = PContactResolver.new

      expect { pcon_resolver.iterations_used = 10 }.to raise_error(NoMethodError)
    end
  end
end