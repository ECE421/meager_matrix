require_relative '../lib/sparse_matrix'

# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrix < SparseMatrix
  attr_reader :diagonal
  attr_reader :rows

  def initialize(diagonal, row_count, column_count)
    @diagonal = diagonal
    @row_count = row_count
    @column_count = column_count
  end

  # Initialize a diagonal sparse matrix from a array based definition
  # Note: non diagonal values will be dropped
  def self.rows(rows, copy = true)
    rows = convert_to_array(rows, copy)
    diagonal = []

    num_col = 0
    num_row = rows.length
    rows.each_with_index do |row, i|
      row = convert_to_array(row, copy)

      num_col = row.length

      next if i >= num_col

      diagonal.push(row[i])
    end
    new diagonal, num_row, num_col
  end

  # TODO: make Matrix.build

  def self.diagonal(*values)
    new values, values.size, values.size
  end

  def new_matrix(diagonal, row_count, column_count)
    self.class.send(:new, diagonal, row_count, column_count)
  end

  def transpose
    new_matrix @diagonal, @column_count, @row_count
  end

  #
  # Returns the DiagonalMatrix as a Matrix.
  #
  def to_matrix
    Matrix.rows(to_a)
  end

  #
  # Returns the number of rows.
  #
  def row_count # rubocop:disable  Style/TrivialAccessors
    @row_count
  end

  def [](i, j)
    if i == j
      @diagonal[i]
    else
      0
    end
  end

  def []=(i, j, v)
    if i != j
      # TODO: is this proper
      raise ArgumentError "Can only set values on the main diagonal
for a DiagonalMatrix"
    end

    @diagonal[i] = v
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @diagonal.map! { |base| base**exponent }
  end

  def to_a
    i = 0
    array = Array.new(@row_count, Array.new(@column_count, 0))
    while i < @diagonal.length
      row = Array.new(@column_count, 0)
      row[i] = diagonal.at(i)
      array[i] = row
      i += 1
    end
    array
  end

  def lower_triangular?
    true
  end

  def upper_triangular?
    true
  end

  def diagonal?
    true
  end

  def symmetric?
    @column_count == @row_count
  end

  def trace
    @diagonal.inject(0, :+)
  end

  def self.zero(row_count, column_count = row_count)
    new Array.new([row_count, column_count].min, 0), row_count, column_count
  end

  def self.scalar(n, value)
    new Array.new(n, 1), n, n
  end

  def self.row_vector(row)
    row = convert_to_array(row)
    # TODO: need check that row only has one diagonal element
    diagonal = if !empty?(row)
                 [row[0]]
               else
                 []
               end
    new diagonal, 1, row.length
  end

  def self.column_vector(column)
    row_vector(column).transpose
  end

  def *(other)
    case other
    when Numeric
      diagonal = @diagonal.collect { |e| e * other }
      new_matrix diagonal, row_count, column_count
    when Vector
      other = self.class.column_vector(other)
      r = self * other
      r.column(0)
    when DiagonalMatrix
      Matrix.Raise ErrDimensionMismatch if column_count != other.row_count

      diagonal = Array.new(@diagonal.size) { |i| @diagonal[i] * other.diagonal[i] }
      new_matrix diagonal, row_count, other.column_count
    when Matrix
      Matrix.Raise ErrDimensionMismatch if column_count != other.row_count

      rows = Array.new(row_count) do |i|
        Array.new(other.column_count) do |j|
          (0...column_count).inject(0) do |vij, k|
            vij + self[i, k] * other[k, j]
          end
        end
      end
      Matrix.rows rows
    else
      apply_through_coercion(other, __method__)
    end
  end

  def +(other)
    case other
    when Numeric
      Matrix.Raise ErrOperationNotDefined, '+', self.class, other.class
    when Vector
      other = self.class.column_vector(other)
    when DiagonalMatrix
      Matrix.Raise ErrDimensionMismatch unless row_count == other.row_count && column_count == other.column_count

      diagonal = Array.new(@diagonal.size) { |i| @diagonal[i] + other.diagonal[i] }
      return new_matrix diagonal, row_count, other.column_count
    when Matrix
      nil
    else
      return apply_through_coercion(other, __method__)
    end
    Matrix.Raise ErrDimensionMismatch unless row_count == other.row_count && column_count == other.column_count

    rows = Array.new(row_count) do |i|
      Array.new(column_count) do |j|
        self[i, j] + other[i, j]
      end
    end
    Matrix.rows(rows)
  end

  def -(other)
    case other
    when Numeric
      Matrix.Raise ErrOperationNotDefined, '-', self.class, other.class
    when Vector
      other = self.class.column_vector(other)
    when DiagonalMatrix
      Matrix.Raise ErrDimensionMismatch unless row_count == other.row_count && column_count == other.column_count

      diagonal = Array.new(@diagonal.size) { |i| @diagonal[i] - other.diagonal[i] }
      return new_matrix diagonal, row_count, other.column_count
    when Matrix
      nil
    else
      return apply_through_coercion(other, __method__)
    end

    Matrix.Raise ErrDimensionMismatch unless row_count == other.row_count && column_count == other.column_count

    rows = Array.new(row_count) do |i|
      Array.new(column_count) do |j|
        self[i, j] - other[i, j]
      end
    end
    Matrix.rows(rows)
  end

  def /(other)
    case other
    when Numeric
      diagonal = @diagonal.collect { |e| e / other }
      new_matrix diagonal, row_count, column_count
    when Matrix
      self * other.inverse
    else
      apply_through_coercion(other, __method__)
    end
  end

  def inverse
    diagonal = @diagonal.collect { |e| 1 / e }
    new_matrix diagonal, row_count, column_count
  end
end
