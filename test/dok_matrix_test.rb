require 'test/unit'
require_relative '../lib/dok_matrix'

class DOKMatrixTest < Test::Unit::TestCase
  # Called before every test method runs.
  # Can be used to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs.
  # Can be used to tear down fixture information.
  def teardown
    # Do nothing
  end

  def test_initialize
    matrix = DOKMatrix.new(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )
    assert_equal({ '1,0': 5, '1,1': 8, '2,2': 3, '3,1': 6 }, matrix.dict)
  end
end
