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
    matrix = DiagonalMatrix.new(
      [0, 0, 0, 0], 4, 4
    )
    assert_equal([0 , 0 , 0 , 0], matrix.diagonal)
  end

  def test_iniitialization_empty
    matrix = DiagonalMatrix.new(
        [], 0, 0
    )
    assert_equal([], matrix.diagonal)
  end

  def test_invalid_row_size
    assert_raises(ArgumentError) {
      DiagonalMatrix.new(
        [0, 0, 0, 0], 3, 4
      )
    }
  end

  def test_invalid_col_size
    assert_raises(ArgumentError) {
      DiagonalMatrix.new(
          [0, 0, 0, 0], 4, 3
      )
    }
  end

  def test_too_small_diagonal
    assert_raises(ArgumentError) do
      DiagonalMatrix.new(
                        [], 1, 1
      )
    end
  end

  def test_to_matrix
    assert_equal([[1, 0], [0, 2]], DiagonalMatrix.new([1, 2], 2, 2).to_matrix)
    assert_equal([[1, 0], [0, 2], [0, 0]], DiagonalMatrix.new([1, 2], 3, 2).to_matrix)
    assert_equal([[1, 0, 0], [0, 2, 0]], DiagonalMatrix.new([1, 2], 2, 3).to_matrix)
  end

  def test_to_matrix_empty
    assert_equal([], DiagonalMatrix.new([], 0, 0).to_matrix)
  end
end
