require 'matrix'

# Abstract class definition of a sparse matrix
class SparseMatrix < Matrix
  def self.rows(rows, copy = true)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def self.to_matrix
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def self.to_a
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  #
  # Returns the number of rows.
  #
  def row_count
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def determinant
    self.to_matrix.determinant
  end

  def eigensystem
    self.to_matrix.eigensystem
  end

  #
  # Returns a new SparseMatrix constructed from a Matrix
  #
  def from_matrix
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end
end
