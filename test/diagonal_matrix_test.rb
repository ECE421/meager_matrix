require 'test/unit'
require_relative '../lib/diagonal_matrix'

class DiagonalMatrixTest < Test::Unit::TestCase

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  # Test the matrix initialization code
  # Based on https://en.wikipedia.org/wiki/Sparse_matrix#Compressed_sparse_row_(CSR,_CRS_or_Yale_format)
  def test_initialization
    assert_equal([0, 0], DiagonalMatrix.rows([[0, 0], [0, 0]]).diagonal)
  end

  def test_rows
    diagonal_matrix = DiagonalMatrix.rows([[0, 0], [0, 0]])
    assert_true(diagonal_matrix.is_a?DiagonalMatrix)
    assert_true(diagonal_matrix.is_a?SparseMatrix)
    assert_true(diagonal_matrix.is_a?Matrix)
    assert_equal([0, 0], diagonal_matrix.diagonal)
    assert_equal([[0, 0], [0, 0]], diagonal_matrix.to_a)
    assert_equal(2, diagonal_matrix.column_count)
    assert_equal(2, diagonal_matrix.row_count)
  end

  def test_to_matrix
    diagonal_matrix = DiagonalMatrix.rows([[0, 0], [0, 0]])
    matrix = diagonal_matrix.to_matrix
    assert_false(matrix.is_a?DiagonalMatrix)
    assert_false(matrix.is_a?SparseMatrix)
    assert_true(matrix.is_a?Matrix)
    assert_equal([[0, 0], [0, 0]], matrix.to_a)
  end

  def test_extra_row_matrix
    diagonal_matrix = DiagonalMatrix.rows([[1, 0], [0, 2], [0, 0]])
    assert_equal([1, 2], diagonal_matrix.diagonal)
    assert_equal([[1, 0], [0, 2], [0, 0]], diagonal_matrix.to_a)
    assert_equal(3, diagonal_matrix.row_count)
    assert_equal(2, diagonal_matrix.column_count)
  end

  def test_extra_col_matrix
    diagonal_matrix = DiagonalMatrix.rows([[1, 0, 0], [0, 2, 0]])
    assert_equal([1, 2], diagonal_matrix.diagonal)
    assert_equal([[1, 0, 0], [0, 2, 0]], diagonal_matrix.to_a)
    assert_equal(2, diagonal_matrix.row_count)
    assert_equal(3, diagonal_matrix.column_count)
  end
end
