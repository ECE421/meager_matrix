require_relative '../lib/tridiagonal_matrix'
require_relative '../lib/sparse_matrix_factory'

# Concrete Factory for TridiagonalMatrix
class TridiagonalMatrixFactory < SparseMatrixFactory
  def build_from_matrix(source_matrix)
    TridiagonalMatrix.rows(source_matrix.to_a, source_matrix.column_count)
  end

  def build_from_array(source_array)
    TridiagonalMatrix.rows(source_array, source_array[0].length)
  end
end
