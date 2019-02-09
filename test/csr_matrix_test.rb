require 'test/unit'
require_relative '../lib/csr_matrix'
require_relative '../lib/csr_matrix_factory'
require_relative '../lib/sparse_matrix_factory'
require_relative 'sparse_matrix_generator'

class CsrMatrixTest < Test::Unit::TestCase
  def setup
    @matrix = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    @sparse_matrix = SparseMatrixFactory.build(@matrix, CSRMatrixFactory.new)
  end

  # Test the matrix initialization code
  # Based on https://en.wikipedia.org/wiki/Sparse_matrix#Compressed_sparse_row_(CSR,_CRS_or_Yale_format)
  def test_initialization
    matrix = CSRMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )
    assert_equal([5, 8, 3, 6], matrix.a_array)
    assert_equal([0, 0, 2, 3, 4], matrix.ia_array)
    assert_equal([0, 1, 2, 1], matrix.ja_array)
  end

  def test_to_a
    assert_equal(@matrix.to_a, @sparse_matrix.to_a, 'to_a failed for csr')
  end

  def test_to_matrix
    assert_equal(@matrix, @sparse_matrix.to_matrix, 'to_array failed for csr')
  end

  def test_add_scalar
    scalar = rand(-100..100)
    actual = @sparse_matrix + scalar
    exp = @matrix + scalar
    assert_equal(exp, actual.to_matrix, 'Addition failed')
  end

  def test_subtract_scalar
    scalar = rand(-100..100)
    actual = @sparse_matrix - scalar
    exp = @matrix - scalar
    assert_equal(exp, actual.to_matrix, 'Subtraction failed')
  end

  def test_divide_scalar
    scalar = rand(-100..100)
    actual = @sparse_matrix / scalar
    exp = @matrix / scalar
    assert_equal(exp, actual.to_matrix, 'Division failed')
  end

  def test_multiply_scalar
    scalar = rand(-100..100)
    actual = @sparse_matrix * scalar
    exp = @matrix * scalar
    assert_equal(exp, actual.to_matrix, 'Multiplication failed')
  end

  def test_add
    matrix = Matrix.build(
      @matrix.row_count,
      @matrix.column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix + matrix
    exp = @matrix + matrix
    assert_equal(exp, actual.to_matrix, 'Matrix addition failed')
  end

  def test_subtract
    matrix = Matrix.build(
      @matrix.row_count,
      @matrix.column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix - matrix
    exp = @matrix - matrix
    assert_equal(exp, actual.to_matrix, 'Matrix subtraction failed')
  end

  def test_divide
    matrix = Matrix.build(
      @matrix.row_count,
      @matrix.column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix / matrix
    exp = @matrix / matrix
    assert_equal(exp, actual.to_matrix, 'Matrix division failed')
  end

  def test_multiply
    matrix = Matrix.build(
      @matrix.row_count,
      @matrix.column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix * matrix
    exp = @matrix * matrix
    assert_equal(exp, actual.to_matrix, 'Matrix multiplication failed')
  end

  def test_power
    scalar = rand(-10..10)
    actual = @sparse_matrix**scalar
    exp = @matrix**scalar
    assert_equal(exp, actual.to_matrix, 'Matrix exponentiation failed')
  end
end
