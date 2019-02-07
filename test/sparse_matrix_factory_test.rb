require 'matrix'
require 'test/unit'
require_relative '../lib/csr_matrix'
require_relative '../lib/csr_matrix_factory'
require_relative '../lib/sparse_matrix_factory'

class SparseMatrixFactoryTest < Test::Unit::TestCase
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

  def test_build_from_matrix
    matrix_input = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(matrix_input, CSRMatrixFactory.new)
    assert(built.is_a?(CSRMatrix))
    assert_equal([1, 1, 1], built.a_array)
  end

  def test_build_from_array
    array_input = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(array_input, CSRMatrixFactory.new)
    assert(built.is_a?(CSRMatrix))
    assert_equal([1, 1, 1], built.a_array)
  end
end
