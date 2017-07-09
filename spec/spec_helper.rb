require './lib/vector'
require './lib/particle'
require './lib/pf_gen'
require './lib/pf_reg'

require 'pry'

def assert_vectors_are_equal(vector1, vector2)
  expect(vector1.x).to eq(vector2.x)
  expect(vector1.y).to eq(vector2.y)
end

def assert_no_mutate(vector)
  x, y = vector.x, vector.y
  yield
  expect(vector.x).to eq(x)
  expect(vector.y).to eq(y)
end