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

  def test_extra_row_matrix
    matrix = DiagonalMatrix.new([[1, 0], [0, 2], [0, 0]])
    assert_equal([[1, 0], [0, 2], [0, 0]], matrix.to_matrix)
    assert_equal([1, 2], matrix.diagonal)
  end

  def test_extra_col_matrix
    matrix = DiagonalMatrix.new([[1, 0, 0], [0, 2, 0]])
    assert_equal([[1, 0, 0], [0, 2, 0]], matrix.to_matrix)
    assert_equal([1, 2], matrix.diagonal)
  end
end
