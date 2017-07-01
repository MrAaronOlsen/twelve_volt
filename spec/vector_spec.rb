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

      vector.invert!

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
      @vector.normalize!

      expect(@vector.x).to be_within(0.0005).of(0.7071)
      expect(@vector.y).to be_within(0.0005).of(0.7071)
    end
  end

  describe 'Vector math' do

    context 'scalar multiplication' do
      before do
        @vector = Vector.new(4, 6)
      end

      it 'multiplies self by a value' do
        @vector.scale!(4)

        expect(@vector.x).to eq(16)
        expect(@vector.y).to eq(24)
      end

      it 'return scaled vector of self' do
        vector = @vector * 2

        expect(vector.x).to eq(8)
        expect(vector.y).to eq(12)
      end
    end

    context 'addition' do
      before do
        @vector = Vector.new(4, 6)
      end

      it 'adds self to another vector' do
        vector = Vector.new(10, 10)
        @vector += vector

        expect(@vector.x).to eq(14)
        expect(@vector.y).to eq(16)
      end

      it 'adds self to another scaled vector' do
        vector = Vector.new(10, 10)
        @vector.add_scaled!(vector, 10)

        expect(@vector.x).to eq(104)
        expect(@vector.y).to eq(106)
      end

      it 'returns added vector of self' do
        vector1 = Vector.new(10, 10)
        vector2 = @vector + vector1

        expect(vector2.x).to eq(14)
        expect(vector2.y).to eq(16)
      end
    end

    context 'subtraction' do
      before do
        @vector = Vector.new(4, 6)
      end

      it 'subtracts self from another vector' do
        vector = Vector.new(10, 10)
        @vector.sub!(vector)

        expect(@vector.x).to eq(-6)
        expect(@vector.y).to eq(-4)
      end

      it 'subtracts self from another scaled vector' do
        vector = Vector.new(10, 10)
        @vector.sub_scaled!(vector, 10)

        expect(@vector.x).to eq(-96)
        expect(@vector.y).to eq(-94)
      end

      it 'returns subtracted vector of self' do
        vector1 = Vector.new(10, 10)
        vector2 = @vector - vector1

        expect(vector2.x).to eq(-6)
        expect(vector2.y).to eq(-4)
      end
    end

    context 'vector multiplication' do
      before do
        @vector = Vector.new(4, 6)
      end

      it 'multiplies self by another vector' do
        vector1 = Vector.new(10, 10)
        @vector.mult!(vector1)

        expect(@vector.x).to eq(40)
        expect(@vector.y).to eq(60)
      end

      it 'returns multiplied vector of self' do
        vector1 = Vector.new(10, 10)
        vector2 = @vector.mult(vector1)

        expect(vector2.x).to eq(40)
        expect(vector2.y).to eq(60)
      end
    end
  end
end