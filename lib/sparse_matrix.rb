require 'matrix'

# Abstract class definition of a sparse matrix
class SparseMatrix < Matrix
  attr_reader :rows
  protected :rows

  def rows(rows, copy = true)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end
end