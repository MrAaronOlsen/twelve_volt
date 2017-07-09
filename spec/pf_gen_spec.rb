require 'spec_helper'

RSpec.describe PForceGenerator do

  before do
    @pfgen = PForceGenerator.new
  end

  describe 'Initialize' do

    it 'is a PForceGenerator' do
      expect(@pfgen).to be_a(PForceGenerator)
    end

  end


end
