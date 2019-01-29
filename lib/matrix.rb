# abstract class defining methods to be implemented as helpers
# for subclassing sub-matrices
class Matrix
  def to_matrix
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def to_array
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def cross
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def determinant
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def dot
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def multiply
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def power
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def trace
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end

  def transpose
    raise NotImplementedError,
          'Matrix is an abstract class please implement methods'
  end
end
