require 'test/unit'
require_relative '../lib/sparse_matrix'

class SparseMatrixTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_rows
    assert_raises(NotImplementedError) { SparseMatrix.rows([[]]) }
  end
end