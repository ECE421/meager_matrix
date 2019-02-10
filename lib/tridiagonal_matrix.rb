# Tridiagonal sparse matrix
class TridiagonalMatrix
  attr_reader(:row_count, :column_count)

  # Basic initialization. Assumes matrix input is properly formatted.
  def initialize(row_count, column_count)
    @row_count = row_count
    @column_count = column_count
  end

  def self.rows(rows, column_count = rows[0].length)
    # TODO: Implement
  end

  def determinant
    # TODO: Implement
  end

  def to_matrix
    # TODO: Implement
  end
end
