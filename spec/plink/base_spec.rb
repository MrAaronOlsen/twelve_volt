require 'spec_helper'

RSpec.describe PLink do

  describe '.initialize' do
    it 'is a PLink' do
      expect(PLink.new).to be_a(PLink)
    end
  end
end
