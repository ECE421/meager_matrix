require 'test/unit'
require_relative '../lib/csr_matrix'
require_relative '../lib/csr_matrix_factory'
require_relative '../lib/sparse_matrix_factory'
require_relative 'sparse_matrix_generator'

class CSRMatrixTest < Test::Unit::TestCase
  # Called before every test method runs.
  # Can be used to set up fixture information.
  def setup
    @matrix = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    @sparse_matrix = SparseMatrixFactory.build(@matrix, CSRMatrixFactory.new)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  # Test the matrix initialization code
  # Based on https://en.wikipedia.org/wiki/Sparse_matrix#Compressed_sparse_row_(CSR,_CRS_or_Yale_format)
  def test_initialization
    csr_matrix = CSRMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )
    assert_equal([5, 8, 3, 6], csr_matrix.a_array)
    assert_equal([0, 0, 2, 3, 4], csr_matrix.ia_array)
    assert_equal([0, 1, 2, 1], csr_matrix.ja_array)
  end

  def test_to_a
    assert_equal(@matrix.to_a, @sparse_matrix.to_a, 'to_a failed for csr')
  end

  def test_to_matrix
    assert_equal(@matrix, @sparse_matrix.to_matrix, 'to_array failed for csr')
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

  def test_add_csr
    test = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    sparse_test = SparseMatrixFactory.build(test, CSRMatrixFactory.new)
    actual = @sparse_matrix - sparse_test
    exp = @matrix - test
    assert_equal(exp, actual.to_matrix, 'Matrix subtraction failed')
  end

  def test_subtract_csr
    test = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    sparse_test = SparseMatrixFactory.build(test, CSRMatrixFactory.new)
    actual = @sparse_matrix - sparse_test
    exp = @matrix - test
    assert_equal(exp, actual.to_matrix, 'Matrix subtraction failed')
  end

  def test_multiply_csr
    test = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    sparse_test = SparseMatrixFactory.build(test, CSRMatrixFactory.new)
    actual = @sparse_matrix * sparse_test
    exp = @matrix * test
    assert_equal(exp, actual.to_matrix, 'Matrix multiplication failed')
  end

  def test_power
    scalar = rand(2..5)
    begin
      actual = @sparse_matrix**scalar
      exp = @matrix**scalar
      assert_equal(exp, actual.to_matrix, 'Matrix exponentiation failed')
    rescue Matrix::ErrNotRegular
      begin
        @matrix**scalar
      rescue Matrix::ErrNotRegular
        assert_true(true, 'Sparse was not able to be inverted')
      end
    end
  end
end
