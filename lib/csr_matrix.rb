require_relative '../lib/sparse_matrix'

# Compressed Sparse Row (CSR) sparse matrix
class CSRMatrix < SparseMatrix
  attr_reader(:a_array, :ia_array, :ja_array, :row_count, :column_count)

  def new_matrix(a_array, ia_array, ja_array, row_count, column_count) # :nodoc:
    self.class.send(:new, a_array, ia_array, ja_array, row_count, column_count) # bypass privacy of Matrix.new
  end

  # Basic initialization. Assumes matrix input is properly formatted.
  def initialize(a_array, ia_array, ja_array, row_count, column_count)
    @a_array = a_array
    @ia_array = ia_array
    @ja_array = ja_array
    @row_count = row_count
    @column_count = column_count
  end

  def self.rows(rows, column_count = rows[0].length)
    arr = rows.is_a?(Matrix) ? rows.to_a : rows

    a_array = []
    ia_array = [0]
    ja_array = []

    arr.each do |row|
      nonzero_count = 0

      row.each_with_index do |value, index|
        next unless value.nonzero?

        nonzero_count += 1
        a_array.insert(a_array.length, value)
        ja_array.insert(ja_array.length, index)
      end
      ia_array.insert(
        ia_array.length,
        ia_array[ia_array.length - 1] + nonzero_count
      )
    end
    new a_array, ia_array, ja_array, rows.length, column_count
  end

  def read_all
    @a_array
  end

  def to_matrix
    matrix = Array.new(row_count) { Array.new(column_count, 0) }
    i = 1
    element = 0
    prev = ia_array[0]
    while i < ia_array.length
      count = ia_array[i] - prev
      count.times do
        j = ja_array[element]
        matrix[i - 1][j] = a_array[element]
        element += 1
      end
      prev = ia_array[i]
      i += 1
    end
    Matrix.rows(matrix)
  end

  def to_a
    to_matrix.to_a
  end

  def **(other)
    raise(TypeError) unless other.is_a?(Numeric)

    super**other # rubocop:disable Layout/SpaceAroundKeyword
  end

  def *(other)
    case other
    when Numeric
      new_array = @a_array.map do |i|
        i * other
      end
      new_matrix new_array, @ia_array, @ja_array, @row_count, @column_count
    when Matrix
      super other
    else
      Matrix.raise NotImplementedError, '*', self.class, other.class
    end
  end

  def /(other)
    case other
    when Numeric
      new_array = @a_array.map do |i|
        i / other
      end
      new_matrix new_array, @ia_array, @ja_array, @row_count, @column_count
    when Matrix
      super other
    else
      Matrix.raise NotImplementedError, '/', self.class, other.class
    end
  end

  def +(other)
    case other
    when Numeric
      Matrix.Raise ErrOperationNotDefined, '+', self.class, other.class
    when Matrix
      super other
    else
      Matrix.raise NotImplementedError, '+', self.class, other.class
    end
  end

  def -(other)
    case other
    when Numeric
      Matrix.Raise ErrOperationNotDefined, '-', self.class, other.class
    when Matrix
      super other
    else
      Matrix.raise NotImplementedError, '+', self.class, other.class
    end
  end
end
