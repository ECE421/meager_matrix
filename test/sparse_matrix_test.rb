require 'test/unit'
require_relative '../lib/sparse_matrix'

class SparseMatrixTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear down fixture information.
  def teardown
    # Do nothing
  end

  # Test the matrix initialization code
  # Based on https://en.wikipedia.org/wiki/Sparse_matrix#Compressed_sparse_row_(CSR,_CRS_or_Yale_format)
  def test_initialization
    matrix = SparseMatrix.new([[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]])
    assert_equal([5, 8, 3, 6], matrix.a_array)
    assert_equal([0, 0, 2, 3, 4], matrix.ia_array)
    assert_equal([0, 1, 2, 1], matrix.ja_array)
  end
end
