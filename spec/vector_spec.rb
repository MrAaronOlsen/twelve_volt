require 'spec_helper'

RSpec.describe Vector do

  describe 'Initialize' do

    it 'is a vector' do
      expect(Vector.new).to be_a_kind_of(Vector)
    end

    it 'returns a default 0 vector' do
      vector = Vector.new

      expect(vector.x).to eq(0)
      expect(vector.y).to eq(0)
    end

    it 'can be assigned x y values' do
      vector = Vector.new(4, 4)

      expect(vector.x).to eq(4)
      expect(vector.y).to eq(4)
    end

    it 'can be inverted' do
      vector = Vector.new(4, 4)

      vector.invert

      expect(vector.x).to eq(-4)
      expect(vector.y).to eq(-4)
    end
  end

  describe 'Direction and magnitude' do
    before do
      @vector = Vector.new(4, 4)
    end

    it 'returns magnitude scaler of vector self' do
      expect(@vector.magnitude).to be_within(0.0005).of(5.6568)
    end

    it 'returns sqrt_magnitude scaler of vector self' do
      expect(@vector.sqrt_magnitude).to eq(32)
    end

    it 'converts self into noramalized vector' do
      @vector.normalize

      expect(@vector.x).to be_within(0.0005).of(0.7071)
      expect(@vector.y).to be_within(0.0005).of(0.7071)
    end
  end
end