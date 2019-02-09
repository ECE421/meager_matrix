require_relative '../lib/dok_matrix'
require_relative '../lib/sparse_matrix_factory'

# Concrete Factory for CSRMatrix
class DoKMatrixFactory < SparseMatrixFactory
  def build_from_matrix(source_matrix)
    DOKMatrix.rows(source_matrix.to_a, source_matrix.column_count)
  end

  def build_from_array(source_array)
    DOKMatrix.rows(source_array, source_array[0].length)
  end
end
