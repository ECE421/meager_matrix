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

  #
  # Returns a new SparseMatrix constructed from a Matrix
  #
  def from_matrix(matrix)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  # TODO: these methods need to convert back
  # TODO: to there original SparseMatrix type
  def determinant
    to_matrix.determinant
  end

  def eigensystem
    to_matrix.eigensystem
  end

  def lup
    to_matrix.lup
  end

  def conjugate
    from_matrix(to_matrix.conjugate)
  end

  def rank
    to_matrix.rank
  end

  def minor(*param)
    from_matrix(to_matrix.minor(*param))
  end

  def first_minor(row, column)
    from_matrix(to_matrix.first_minor(row, column))
  end
end
