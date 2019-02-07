require_relative '../lib/csr_matrix'
require_relative '../lib/sparse_matrix_factory'

# Concrete Factory for CSRMatrix
class CSRMatrixFactory < SparseMatrixFactory
  def build_from_matrix(source_matrix)
    CSRMatrix.rows(source_matrix.to_a, source_matrix.column_count)
  end

  def build_from_array(source_array)
    CSRMatrix.rows(source_array, source_array[0].length)
  end
end
