require_relative '../lib/sparse_matrix'

# Tridiagonal sparse matrix
class TridiagonalMatrix < SparseMatrix
  attr_reader(:tridiagonal, :row_count, :column_count)

  # Basic initialization. Assumes matrix input is properly formatted.
  def initialize(tridiagonal, row_count, column_count)
    @tridiagonal = tridiagonal
    @row_count = row_count
    @column_count = column_count
  end

  def self.rows(rows, column_count = rows[0].length)
    row_count = rows.size

    raise ArgumentError unless row_count == column_count and row_count > 2

    tridiagonal = []
    if column_count == 0
      new tridiagonal, row_count, column_count
      return
    end
    rows.each.with_index do |row, i|
      tri_row = Array.new(3, 0)
      tri_row[0] = i - 1 < 0 ? 0 : row[i-1]
      tri_row[1] = row[i]
      tri_row[2] = i + 1 >= column_count ? 0 : row[i+1]
      tridiagonal.push(tri_row)
    end
    new tridiagonal, row_count, column_count
  end

  def [] (row, col)
    if (row-col).abs > 1
      0
    else
      @tridiagonal[row][1 - (row-col)]
    end

  end

  def determinant(n = @row_count)
    # https://math.stackexchange.com/questions/1571038
    return 1 if n.zero?
    return self[0, 0] if n == 1
    self[n-1, n-1] * determinant(n-1) - self[n-1, n-2] *
        self[n-2, n-1] * determinant(n-2)
  end

  def to_a
    i = 0
    array = Array.new(@row_count) { Array.new(@column_count, 0) }
    while i < @row_count
      row = Array.new(@column_count, 0)
      i - 1 < 0 ? nil : row[i-1] = @tridiagonal[i][0]
      row[i] = @tridiagonal[i][1]
      i + 1 >= @column_count ? nil : row[i+1] = @tridiagonal[i][2]
      array[i] = row
      i += 1
    end
    array
  end

  def to_matrix
    Matrix.rows(to_a)
  end

  def zero?
    @tridiagonal.each do |row|
      return false unless (row - [0]).empty? or row.empty?
    end
    true
  end
end
