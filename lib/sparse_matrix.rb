require 'matrix'

# Abstract class definition of a sparse matrix
class SparseMatrix < Matrix
  def self.to_matrix
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def self.to_a
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def trace
    Matrix.Raise ErrDimensionMismatch unless square?
    (0...column_count).inject(0) do |tr, i|
      tr + @rows.to_a[i][i]
    end
  end

  private def set_value(row, col, value)
    raise ErrDimensionMismatch, "Expected a a value, got a #{value.class}" if value.respond_to?(:to_matrix)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  private def set_row_and_col_range(row_range, col_range, value)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  private def set_row_range(row_range, col, value)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  private def set_column_vector(row_range, col, value)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  private def set_col_range(row, col_range, value)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def row_count
    @rows.to_a.size
  end

  def column(j) # :yield: e
    if block_given?
      return self if j >= column_count || j < -column_count
      row_count.times do |i|
        yield @rows.to_a[i][j]
      end
      self
    else
      return nil if j >= column_count || j < -column_count
      col = Array.new(row_count) {|i|
        @rows.to_a[i][j]
      }
      Vector.elements(col, false)
    end
  end

  def collect!(which = :all)
    return to_enum(:collect!, which) unless block_given?
    raise FrozenError, "can't modify frozen Matrix" if frozen?
    each_with_index(which){ |e, row_index, col_index| @rows.to_a[row_index][col_index] = yield e }
  end

  def minor(*param)
    case param.size
    when 2
      row_range, col_range = param
      from_row = row_range.first
      from_row += row_count if from_row < 0
      to_row = row_range.end
      to_row += row_count if to_row < 0
      to_row += 1 unless row_range.exclude_end?
      size_row = to_row - from_row

      from_col = col_range.first
      from_col += column_count if from_col < 0
      to_col = col_range.end
      to_col += column_count if to_col < 0
      to_col += 1 unless col_range.exclude_end?
      size_col = to_col - from_col
    when 4
      from_row, size_row, from_col, size_col = param
      return nil if size_row < 0 || size_col < 0
      from_row += row_count if from_row < 0
      from_col += column_count if from_col < 0
    else
      raise ArgumentError, param.inspect
    end

    return nil if from_row > row_count || from_col > column_count || from_row < 0 || from_col < 0
    rows = @rows.to_a[from_row, size_row].collect{|row|
      row[from_col, size_col]
    }
    new_matrix rows, [column_count - from_col, size_col].min
  end


  private def inverse_from(src) # :nodoc:
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end

  def determinant
    Matrix.Raise ErrDimensionMismatch unless square?
    m = @rows.to_a
    case row_count
      # Up to 4x4, give result using Laplacian expansion by minors.
      # This will typically be faster, as well as giving good results
      # in case of Floats
    when 0
      +1
    when 1
      + m[0][0]
    when 2
      + m[0][0] * m[1][1] - m[0][1] * m[1][0]
    when 3
      m0, m1, m2 = m
      + m0[0] * m1[1] * m2[2] - m0[0] * m1[2] * m2[1] \
      - m0[1] * m1[0] * m2[2] + m0[1] * m1[2] * m2[0] \
      + m0[2] * m1[0] * m2[1] - m0[2] * m1[1] * m2[0]
    when 4
      m0, m1, m2, m3 = m
      + m0[0] * m1[1] * m2[2] * m3[3] - m0[0] * m1[1] * m2[3] * m3[2] \
      - m0[0] * m1[2] * m2[1] * m3[3] + m0[0] * m1[2] * m2[3] * m3[1] \
      + m0[0] * m1[3] * m2[1] * m3[2] - m0[0] * m1[3] * m2[2] * m3[1] \
      - m0[1] * m1[0] * m2[2] * m3[3] + m0[1] * m1[0] * m2[3] * m3[2] \
      + m0[1] * m1[2] * m2[0] * m3[3] - m0[1] * m1[2] * m2[3] * m3[0] \
      - m0[1] * m1[3] * m2[0] * m3[2] + m0[1] * m1[3] * m2[2] * m3[0] \
      + m0[2] * m1[0] * m2[1] * m3[3] - m0[2] * m1[0] * m2[3] * m3[1] \
      - m0[2] * m1[1] * m2[0] * m3[3] + m0[2] * m1[1] * m2[3] * m3[0] \
      + m0[2] * m1[3] * m2[0] * m3[1] - m0[2] * m1[3] * m2[1] * m3[0] \
      - m0[3] * m1[0] * m2[1] * m3[2] + m0[3] * m1[0] * m2[2] * m3[1] \
      + m0[3] * m1[1] * m2[0] * m3[2] - m0[3] * m1[1] * m2[2] * m3[0] \
      - m0[3] * m1[2] * m2[0] * m3[1] + m0[3] * m1[2] * m2[1] * m3[0]
    else
      # For bigger matrices, use an efficient and general algorithm.
      # Currently, we use the Gauss-Bareiss algorithm
      determinant_bareiss
    end
  end

  def transpose
    return self.class.empty(column_count, 0) if row_count.zero?
    new_matrix @rows.to_a.transpose, row_count
  end

  def from_matrix(matrix)
    raise NotImplementedError,
          'SparseMatrix is an abstract class please implement methods'
  end


  ## FETCH

  #
  # Returns row vector number +i+ of the matrix as a Vector (starting at 0 like
  # an array).  When a block is given, the elements of that vector are iterated.
  #
  def row(i, &block) # :yield: e
    if block_given?
      @rows.to_a.fetch(i){return self}.each(&block)
      self
    else
      Vector.elements(@rows.to_a.fetch(i){return nil})
    end
  end

  #
  # Returns element (+i+,+j+) of the matrix.  That is: row +i+, column +j+.
  #
  def [](i, j)
    @rows.to_a.fetch(i){return nil}[j]
  end

end
