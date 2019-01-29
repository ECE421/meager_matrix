# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrix
  attr_reader(:diagonal)

  # Initialize a diagonal sparse matrix from a array based definition
  # Note: non diagonal values will be dropped
  def initialize(*args)
    @diagonal = []
    return unless args.length.nonzero?
    raise(TypeError) unless args[0].is_a?(Array)

    matrix = args[0]
    @num_row = matrix.length
    matrix.each_with_index do |row, i|
      raise(TypeError) unless row.is_a?(Array)

      @num_col = row.length

      next if i >= @num_col

      @diagonal.push(row[i])
    end
  end

  # return the DiagonalMatrix as a @num_row long Array of @num_col long Arrays
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

  def read_all
    @diagonal
  end
end
