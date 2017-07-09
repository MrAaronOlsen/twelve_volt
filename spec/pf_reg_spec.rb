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
end