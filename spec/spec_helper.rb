require 'simplecov'
SimpleCov.start do
  add_filter "spec/"
end

require './spec/test_helper'
include TestHelper

require './lib/vector'
require './lib/particle'
require './lib/pf_gen'
require './lib/pf_reg'
require './lib/p_contact'
require './lib/p_contact_resolver'

require 'pry'

