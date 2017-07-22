module TestHelper

  def assert_vectors_are_equal(vector1, vector2)
    expect(vector1.x).to eq(vector2.x)
    expect(vector1.y).to eq(vector2.y)
  end

  def expect_vector(x, y, vector)
    expect(vector.x).to eq(x)
    expect(vector.y).to eq(y)
  end

  def assert_no_mutate(vector)
    x, y = vector.x, vector.y
    yield
    expect(vector.x).to eq(x)
    expect(vector.y).to eq(y)
  end
end