require 'test/unit'
require_relative '../lib/tridiagonal_matrix'
require_relative '../lib/sparse_matrix_factory'
require_relative 'sparse_matrix_generator'
require_relative '../lib/tridiagonal_matrix_factory'

class TridiagonalMatrixTest < Test::Unit::TestCase
  # Called before every test method runs.
  # Can be used to set up fixture information.
  def setup
    @row_count = 5
    @column_count = 5
    @matrix = SparseMatrixGenerator.generate_diag_matrix(@row_count, @column_count, band_width: 3, band_offset: -1)
    @sparse_matrix = SparseMatrixFactory.build(@matrix, TridiagonalMatrixFactory.new)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  def test_indexing
    (0..@row_count-1).each do |row|
      (0..@column_count-1).each do |col|
        assert_equal(@matrix[row, col], @sparse_matrix[row, col])
      end
    end
  end

  def test_to_matrix
    assert_equal(@matrix, @sparse_matrix.to_matrix, 'to_matrix failed')
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
        @row_count,
        @column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix + matrix
    exp = @matrix + matrix
    assert_equal(exp, actual.to_matrix, 'Matrix addition failed')
  end

  def test_subtract
    matrix = Matrix.build(
        @row_count,
        @column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix - matrix
    exp = @matrix - matrix
    assert_equal(exp, actual.to_matrix, 'Matrix subtraction failed')
  end

  def test_divide
    matrix = Matrix.build(
        @row_count,
        @column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix / matrix
    exp = @matrix / matrix
    assert_equal(exp, actual.to_matrix, 'Matrix division failed')
  end

  def test_multiply
    matrix = Matrix.build(
        @row_count,
        @column_count
    ) { rand(-10..10) }
    actual = @sparse_matrix * matrix
    exp = @matrix * matrix
    assert_equal(exp, actual.to_matrix, 'Matrix multiplication failed')
  end

  def test_power
    scalar = rand(2..5)
    begin
      actual = @sparse_matrix**scalar
      exp = @matrix**scalar
      assert_equal(exp, actual.to_matrix, 'Matrix exponentiation failed')
    rescue Matrix::ErrNotRegular
      assert_true(@matrix.regular?, 'Matrix was not irregular')
    end
  end

  def test_transpose
    assert_equal(@sparse_matrix.to_matrix, @sparse_matrix.transpose.transpose.to_matrix)
    assert_equal(
        @matrix.transpose,
        @sparse_matrix.transpose.to_matrix
    )
  end

  def test_determinant
    assert_equal(
        @matrix.determinant,
        @sparse_matrix.determinant,
    )
  end

  def test_zero_true
    matrix = Matrix.zero(@row_count, @column_count)
    sparse_matrix = SparseMatrixFactory.build(matrix, TridiagonalMatrixFactory.new)
    assert_true(sparse_matrix.zero?, 'Matrix zero failed')
  end

  def test_zero_false
    matrix = SparseMatrixGenerator.generate_diag_matrix(@row_count, @column_count, band_width: 3, band_offset: -1)
    sparse_matrix = SparseMatrixFactory.build(matrix, TridiagonalMatrixFactory.new)
    assert_false(sparse_matrix.zero?, 'Matrix zero failed')
  end
end
