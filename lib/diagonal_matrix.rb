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
      raise(ArgumentError)
    end
    @diagonal = diagonal
    @num_row = m
    @num_col = n
  end

  # return the DiagonalMatrix as a m long Array of n long Arrays
  def to_matrix
    i = 0
    matrix = Array.new(@num_row, Array.new(@num_col, 0))
    while i < @diagonal.length
      row = Array.new(@num_col, 0)
      row[i] = diagonal.at(i)
      matrix[i] = row
      puts(matrix)
      i = i+1
    end
    matrix
  end
end
