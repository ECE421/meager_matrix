require 'test/unit'
require_relative '../lib/diagonal_matrix'
require_relative 'sparse_matrix_generator'

class DiagonalMatrixTest < Test::Unit::TestCase
  def setup
    @matrix = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
  end

  def teardown
    # Do nothing
  end

  def test_initialization
    assert_equal([0, 0], DiagonalMatrix.rows([[0, 0], [0, 0]]).diagonal)
  end

  def test_rows
    diagonal_matrix = DiagonalMatrix.rows([[0, 0], [0, 0]])
    assert_true(diagonal_matrix.is_a?(DiagonalMatrix))
    assert_true(diagonal_matrix.is_a?(SparseMatrix))
    assert_true(diagonal_matrix.is_a?(Matrix))
    assert_equal([0, 0], diagonal_matrix.diagonal)
    assert_equal([[0, 0], [0, 0]], diagonal_matrix.to_a)
    assert_equal(2, diagonal_matrix.column_count)
    assert_equal(2, diagonal_matrix.row_count)
  end

  def test_to_matrix
    diagonal_matrix = DiagonalMatrix.rows([[0, 0], [0, 0]])
    matrix = diagonal_matrix.to_matrix
    assert_false(matrix.is_a?(DiagonalMatrix))
    assert_false(matrix.is_a?(SparseMatrix))
    assert_true(matrix.is_a?(Matrix))
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

  def test_transpose
    diagonal_matrix = DiagonalMatrix.rows([[1, 0, 0], [0, 2, 0]])
    transposed_matrix = diagonal_matrix.transpose
    assert_equal([1, 2], transposed_matrix.diagonal)
    assert_equal([[1, 0], [0, 2], [0, 0]], transposed_matrix.to_a)
  end

  def test_list_accessor
    diagonal_matrix = DiagonalMatrix.rows([[1, 0, 0], [0, 2, 0]])
    assert_equal(1, diagonal_matrix[0, 0])
    assert_equal(0, diagonal_matrix[0, 1])
    assert_equal(0, diagonal_matrix[0, 2])
    assert_equal(0, diagonal_matrix[1, 0])
    assert_equal(2, diagonal_matrix[1, 1])
    assert_equal(0, diagonal_matrix[1, 2])
  end

  def test_trace
    diagonal_matrix = DiagonalMatrix.rows([[1, 0, 0], [0, 2, 0]])
    assert_equal(3, diagonal_matrix.trace)
    assert_equal([1, 2], diagonal_matrix.diagonal)
  end

  def test_identity
    diagonal_matrix = DiagonalMatrix.identity(3)
    assert_equal(3, diagonal_matrix.row_count)
    assert_equal(3, diagonal_matrix.column_count)
    assert_equal([1, 1, 1], diagonal_matrix.diagonal)
  end

  def test_multiply_matrix
    d1 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d2 = d1 * Matrix.rows([[2, 0], [2, 2]])
    assert_equal([[2, 0], [4, 4]], d2.to_a)
    assert_false(d2.is_a?(DiagonalMatrix))
    assert_true(d2.is_a?(Matrix))
  end

  def test_multiply_number
    d = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d *= 2
    assert_equal([[2, 0], [0, 4]], d.to_a)
    assert_true(d.is_a?(DiagonalMatrix))
  end

  def test_multiply_diagonal
    d1 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d2 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d3 = d1 * d2
    assert_equal([[1, 0], [0, 4]], d3.to_a)
    assert_true(d3.is_a?(DiagonalMatrix))
  end

  def test_addition_diagonal
    d1 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d2 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d3 = d1 + d2
    assert_equal([[2, 0], [0, 4]], d3.to_a)
    assert_true(d3.is_a?(DiagonalMatrix))
  end

  def test_addition_matrix
    d1 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d2 = Matrix.rows([[1, 0], [0, 2]])
    d3 = d1 + d2
    assert_equal([[2, 0], [0, 4]], d3.to_a)
    assert_true(d3.is_a?(Matrix))
  end

  def test_subtract_diagonal
    d1 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d2 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d3 = d1 - d2
    assert_equal([[0, 0], [0, 0]], d3.to_a)
    assert_true(d3.is_a?(DiagonalMatrix))
  end

  def test_subtraction_matrix
    d1 = DiagonalMatrix.rows([[1, 0], [0, 2]])
    d2 = Matrix.rows([[1, 0], [0, 2]])
    d3 = d1 - d2
    assert_equal([[0, 0], [0, 0]], d3.to_a)
    assert_true(d3.is_a?(Matrix))
    assert_false(d3.is_a?(DiagonalMatrix))
  end

  def test_divide_diagonal
    d1 = DiagonalMatrix.rows([[1.0, 0.0], [0.0, 2.0]])
    d2 = DiagonalMatrix.rows([[1.0, 0.0], [0.0, 2.0]])
    d3 = d1 / d2
    assert_equal([[1.0, 0.0], [0.0, 1.0]], d3.to_a)
    assert_true(d3.is_a?(DiagonalMatrix))
  end

  def test_divide_matrix
    d1 = DiagonalMatrix.rows([[1.0, 0.0], [0.0, 2.0]])
    d2 = Matrix.rows([[1.0, 0.0], [0.0, 2.0]])
    d3 = d1 / d2
    assert_equal([[1.0, 0.0], [0.0, 1.0]], d3.to_a)
    assert_true(d3.is_a?(Matrix))
    assert_false(d3.is_a?(DiagonalMatrix))
  end

  def test_divide_numeric
    d1 = DiagonalMatrix.rows([[1.0, 0.0], [0.0, 2.0]])
    d3 = d1 / 2
    assert_equal([[0.5, 0.0], [0.0, 1.0]], d3.to_a)
    assert_true(d3.is_a?(DiagonalMatrix))
  end
end
