require_relative '../lib/diagonal_matrix'
require_relative '../lib/sparse_matrix_factory'

# Concrete Factory for DiagonalMatrix
class DiagonalMatrixFactory < SparseMatrixFactory
  def build_from_matrix(source_matrix)
    DiagonalMatrix.rows(source_matrix.to_a, source_matrix.column_count)
  end

  def build_from_array(source_array)
    DiagonalMatrix.rows(source_array, source_array[0].length)
  end
end
