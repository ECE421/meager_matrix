require 'test/unit'
require_relative '../lib/sparse_matrix'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_rows
    assert_raises(NotImplementedError) { SparseMatrix.rows([[]]) }
  end
  # Fake test
end