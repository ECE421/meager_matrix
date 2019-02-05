require_relative '../lib/sparse_matrix'

# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrix < SparseMatrix
  attr_reader(:diagonal)

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

  # return the DiagonalMatrix as a @num_row long Array of @num_col long Arrays
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

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @diagonal.map! { |base| base**exponent }
  end

  def read_all
    @diagonal
  end
end
