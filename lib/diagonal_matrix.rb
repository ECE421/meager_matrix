# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrix
  attr_reader(:diagonal)

  # create an mxn matrix with the given array values as the
  # values populating the main diagonal of the matrix
  # if m or n are not given they are set to the length of the
  # diagonal array
  def initialize(diagonal, num_row, num_col)
    raise(TypeError) unless diagonal.is_a?(Array)

    raise(TypeError) unless num_row.is_a?(Integer)

    raise(TypeError) unless num_col.is_a?(Integer)

    raise(ArgumentError) unless
        diagonal.length == num_col || diagonal.length == num_row

    if diagonal.length > num_row || diagonal.length > num_col
      raise(ArgumentError)
    end

    @diagonal = diagonal
    @num_row = num_row
    @num_col = num_col
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
      i += 1
    end
    matrix
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)
    @diagonal.map! { |base| base**exponent }
  end
end
