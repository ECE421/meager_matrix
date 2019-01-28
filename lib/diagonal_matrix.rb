# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrix
  attr_reader(:diagonal)

  # create an mxn matrix with the given array values as the
  # values populating the main diagonal of the matrix
  def initialize(diagonal, m, n)
    raise(TypeError) unless diagonal.is_a?(Array)
    raise(TypeError) unless m.is_a?(Integer)
    raise(TypeError) unless n.is_a?(Integer)
    raise(ArgumentError) unless diagonal.length == n or diagonal.length == m
    if diagonal.length > m or diagonal.length > n
      puts("he")
      raise(ArgumentError)
    end
    @diagonal = diagonal
    @num_row = m
    @num_col = n
  end

  # convert the DiagonalMatrix into a standard SparseMatrix
  def to_matrix

  end
end
