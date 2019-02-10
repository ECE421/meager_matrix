require 'test/unit'
require_relative '../lib/dok_matrix'
require_relative '../lib/sparse_matrix_factory'
require_relative 'sparse_matrix_generator'
require_relative '../lib/dok_matrix_factory'

class DOKMatrixTest < Test::Unit::TestCase
  # Called before every test method runs.
  # Can be used to set up fixture information.
  def setup
    @matrix = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    @sparse_matrix = SparseMatrixFactory.build(@matrix, DOKMatrixFactory.new)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  def test_initialize
    matrix = DOKMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )
    assert_equal({ [1, 0] => 5, [1, 1] => 8, [2, 2] => 3, [3, 1] => 6 }, matrix.dict)
  end

  def test_initialize_no_args
    matrix = DOKMatrix.rows([[]])
    assert_equal({}, matrix.dict)
  end

  def test_get
    matrix = DOKMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )
    assert_equal(8, matrix.read(1, 1))
    assert_equal(nil, matrix.read(0, 0))
  end

  def test_insert
    matrix = DOKMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )

    # Test inserting value to an empty index
    assert_equal(nil, matrix.read(0, 0))
    matrix[0, 0] = 10
    assert_equal(10, matrix.read(0, 0))

    # Test overwriting value
    assert_equal(5, matrix.read(1, 0))
    matrix[1, 0] = 6
    assert_equal(6, matrix.read(1, 0))
  end

  def test_insert_zero
    matrix = DOKMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )

    # Test overwriting with 0
    assert_equal(5, matrix.read(1, 0))
    matrix[1, 0] = 0
    assert_equal(nil, matrix.read(1, 0))

    # Test overwriting with nil
    assert_equal(8, matrix.read(1, 1))
    matrix[1, 1] = nil
    assert_equal(nil, matrix.read(1, 1))
  end

  def test_insert_invalid_value
    matrix = DOKMatrix.rows([[]])
    assert_raises(TypeError) { matrix[0, 0] = 'a' }
  end

  def test_insert_invalid_index
    matrix = DOKMatrix.rows([[]])
    assert_raises(ArgumentError) { matrix[-1, -1] = 10 }
  end

  def test_delete
    matrix = DOKMatrix.rows(
      [[0, 0, 0, 0], [5, 8, 0, 0], [0, 0, 3, 0], [0, 6, 0, 0]]
    )
    matrix.delete(1, 0)
    assert_equal({ [1, 1] => 8, [2, 2] => 3, [3, 1] => 6 }, matrix.dict)
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

  def test_add_dok
    test = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    sparse_test = SparseMatrixFactory.build(test, DoKMatrixFactory.new)
    actual = @sparse_matrix + sparse_test
    exp = @matrix + test
    assert_equal(exp, actual.to_matrix, 'Matrix addition failed')
  end

  def test_subtract_dok
    test = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    sparse_test = SparseMatrixFactory.build(test, DoKMatrixFactory.new)
    actual = @sparse_matrix - sparse_test
    exp = @matrix - test
    assert_equal(exp, actual.to_matrix, 'Matrix subtraction failed')
  end

  def test_multiply_dok
    test = SparseMatrixGenerator.generate_sparse_matrix(4, 4)
    sparse_test = SparseMatrixFactory.build(test, DoKMatrixFactory.new)
    actual = @sparse_matrix * sparse_test
    exp = @matrix * test
    assert_equal(exp, actual.to_matrix, 'Matrix multiplication failed')
  end

  def test_power
    scalar = rand(0..10)
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

  def test_transpose
    assert_equal(@sparse_matrix, @sparse_matrix.transpose.transpose)
    assert_equal(
      @matrix.transpose,
      @sparse_matrix.transpose.to_matrix
    )
  end

  def test_zero_empty
    matrix = DOKMatrix.rows([[]])
    assert_true(matrix.zero?)
  end

  def test_zero_true
    matrix = DOKMatrix.rows([[0]])
    assert_true(matrix.zero?)
  end

  def test_zero_false
    matrix = DOKMatrix.rows([[1]])
    assert_false(matrix.zero?)
  end
end
