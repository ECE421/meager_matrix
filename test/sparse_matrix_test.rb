require 'test/unit'
require_relative '../lib/csr_matrix'
require_relative '../lib/dok_matrix'
require_relative '../lib/sparse_matrix'

class SparseMatrixTest < Test::Unit::TestCase
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

  def test_power!
    raw_data = [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    types = %w[csr dok]

    types.each do |type|
      if type == 'diagonal'
        matrix = SparseMatrix.new(raw_data, type)

        matrix.power!(2)
        after_power = matrix.read_all!
        assert_equal([0, 64, 9, 0], after_power)

        matrix.power!(0.5)
        after_power = matrix.read_all!
        assert_equal([0, 8.0, 3.0, 0], after_power)
      else
        matrix = SparseMatrix.new(raw_data, type)

        matrix.power!(2)
        after_power = matrix.read_all!
        assert_equal([25, 64, 9, 36], after_power)

        matrix.power!(0.5)
        after_power = matrix.read_all!
        assert_equal([5.0, 8.0, 3.0, 6.0], after_power)
      end
    end
  end
end
