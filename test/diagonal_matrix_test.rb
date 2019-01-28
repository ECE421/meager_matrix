require 'test/unit'
require_relative '../lib/diagonal_matrix'

class DiagonalMatrixTest < Test::Unit::TestCase
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

  # Test the matrix initialization code
  # Based on https://en.wikipedia.org/wiki/Sparse_matrix#Compressed_sparse_row_(CSR,_CRS_or_Yale_format)
  def test_initialization
    assert_equal([0, 0], DiagonalMatrix.new([[0, 0], [0, 0]]).diagonal)
  end

  def test_initialization_empty
    assert_equal([], DiagonalMatrix.new([]).diagonal)
  end

  def test_power
    raw_data = [[1, 0, 0, 0], [0, 8, 0, 0], [0, 0, 3, 0], [0, 0, 0, 6]]

    matrix = DiagonalMatrix.new(raw_data)

    matrix.power(2)
    after_power = matrix.read_all
    assert_equal([1, 64, 9, 36], after_power)

    matrix.power(0.5)
    after_power = matrix.read_all
    assert_equal([1, 8.0, 3.0, 6.0], after_power)
  end
end
