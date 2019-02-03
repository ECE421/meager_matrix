require 'test/unit'
require_relative '../lib/csr_matrix'
require_relative '../lib/diagonal_matrix'
require_relative '../lib/dok_matrix'
require_relative '../lib/sparse_matrix'
require_relative './sparse_matrix_generator'

class SparseMatrixTest < Test::Unit::TestCase
  @array_types = ['csr']
  # Called before every test method runs.
  # Can be used to set up fixture information.
  def setup
    @matrix = TestMatrixGenerator.generate_sparse_matrix(4,4)
    @sparse_matrix = SparseMatrix.new(@matrix)
  end

  # Called after every test method runs.
  # Can be used to tear down fixture information.
  def teardown
    # Do nothing
  end

  def test_to_matrix
    @sparse_matrix = SparseMatrix.new(@matrix)
    assert_equal(@matrix, @sparse_matrix.to_matrix, "to_array failed for csr")
  end

  def test_add_scalar
    scalar = rand(-100..100)
    @sparse_matrix + scalar
    @matrix + scalar
    assert_equal(@matrix, @sparse_matrix.to_matrix, "Addition failed")
  end

  def test_subtract_scalar
    scalar = rand(-100..100)
    @sparse_matrix - scalar
    @matrix - scalar
    assert_equal(@matrix, @sparse_matrix.to_matrix, "Subtraction failed")
  end

  def test_divide_scalar
    scalar = rand(-100..100)
    @sparse_matrix / scalar
    @matrix / scalar
    assert_equal(@matrix, @sparse_matrix.to_matrix, "Division failed")
  end

  def test_multiply_scalar
    scalar = rand(-100..100)
    @sparse_matrix * scalar
    @matrix * scalar
    assert_equal(@matrix, @sparse_matrix.to_matrix, "Multiplication failed")

  end

  def test_add

  end

  def test_subtract

  end

  def test_divide

  end

  def test_multiply

  end

  def test_power

  end

  def test_dot

  end

  def test_toMatrix

  end

  def test_equals

  end


end
