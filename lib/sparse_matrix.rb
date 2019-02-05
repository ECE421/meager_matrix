require 'matrix'

# Abstract class definition of a sparse matrix
class SparseMatrix < Matrix
  def self.rows(rows, copy = true)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end
end
