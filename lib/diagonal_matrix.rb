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
    diagonal = []
    raise(TypeError) unless rows.is_a?(Array)

    num_col = 0
    num_row = rows.length
    rows.each_with_index do |row, i|
      raise(TypeError) unless row.is_a?(Array)

      num_col = row.length

      next if i >= num_col

      diagonal.push(row[i])
    end
    new diagonal, num_row, num_col
  end

  def self.diagonal(values,
                    row_count = values.length,
                    column_count = values.length)
    new values, row_count, column_count
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
    i = 0
    matrix = Array.new(@row_count, Array.new(@column_count, 0))
    while i < @diagonal.length
      row = Array.new(@column_count, 0)
      row[i] = diagonal.at(i)
      matrix[i] = row
      puts(matrix)
      i += 1
    end
    Matrix.rows(matrix)
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
      puts(array)
      i += 1
    end
    array
  end
end
