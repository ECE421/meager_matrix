require 'matrix'
require 'test/unit'
require_relative '../lib/csr_matrix'
require_relative '../lib/csr_matrix_factory'
require_relative '../lib/diagonal_matrix'
require_relative '../lib/diagonal_matrix_factory'
require_relative '../lib/dok_matrix'
require_relative '../lib/dok_matrix_factory'
require_relative '../lib/sparse_matrix_factory'

class SparseMatrixFactoryTest < Test::Unit::TestCase
  def test_build_csr_from_matrix
    matrix_input = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(matrix_input, CSRMatrixFactory.new)
    assert(built.is_a?(CSRMatrix))
    assert_equal([1, 1, 1], built.read_all)
  end

  def test_build_dok_from_matrix
    matrix_input = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(matrix_input, DOKMatrixFactory.new)
    assert(built.is_a?(DOKMatrix))
    assert_equal([1, 1, 1], built.read_all)
  end

  def test_build_diagonal_from_matrix
    matrix_input = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(matrix_input, DiagonalMatrixFactory.new)
    assert(built.is_a?(DiagonalMatrix))
    assert_equal([1, 1, 1], built.read_all)
  end

  def test_build_csr_from_array
    array_input = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(array_input, CSRMatrixFactory.new)
    assert(built.is_a?(CSRMatrix))
    assert_equal([1, 1, 1], built.read_all)
  end

  def test_build_dok_from_array
    array_input = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(array_input, DOKMatrixFactory.new)
    assert(built.is_a?(DOKMatrix))
    assert_equal([1, 1, 1], built.read_all)
  end

  def test_build_diagonal_from_array
    array_input = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    built = SparseMatrixFactory.build(array_input, DiagonalMatrixFactory.new)
    assert(built.is_a?(DiagonalMatrix))
    assert_equal([1, 1, 1], built.read_all)
  end
end
