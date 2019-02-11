require_relative '../lib/sparse_matrix'

# Compressed Sparse Row (CSR) sparse matrix
class CSRMatrix < SparseMatrix
  attr_reader(:a_array, :ia_array, :ja_array, :row_count, :column_count)

  def new_matrix(a_array, ia_array, ja_array, row_count, column_count) # :nodoc:
    self.class.send(:new, a_array, ia_array, ja_array, row_count, column_count) # bypass privacy of Matrix.new
  end

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

  def [](row, col)
    read(row, col)
  end

  def []=(row, col, value)
    raise(ArgumentError) unless row >= 0 && col >= 0
    raise(TypeError) unless value.is_a?(Numeric) || value.nil?

    value.nil? || value.zero? ? delete(row, col) : set_value(row, col, value)
  end
  alias set_element []=
  alias set_component []=

  def **(other)
    raise(TypeError) unless other.is_a?(Numeric)

    super other
  end

  def *(other)
    case other
    when Numeric
      new_array = @a_array.map do |i|
        i * other
      end
      new_matrix new_array, @ia_array, @ja_array, @row_count, @column_count
    when Matrix
      super other.to_matrix
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
      super other.to_matrix
    else
      Matrix.raise NotImplementedError, '/', self.class, other.class
    end
  end

  def +(other)
    case other
    when Numeric
      Matrix.Raise ErrOperationNotDefined, '+', self.class, other.class
    when Matrix
      super other.to_matrix
    else
      Matrix.raise NotImplementedError, '+', self.class, other.class
    end
  end

  def -(other)
    case other
    when Numeric
      Matrix.Raise ErrOperationNotDefined, '-', self.class, other.class
    when Matrix
      super other.to_matrix
    else
      Matrix.raise NotImplementedError, '+', self.class, other.class
    end
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

  def read(row, col)
    prev_row_count = @ia_array[row]
    row_count = @ia_array[row+1]
    if row_count - prev_row_count > 0
      i = prev_row_count
      while i < row_count do
        if col == @ja_array[i]
          return @a_array[i]
        end
        i += 1
      end
    else
      return nil
    end
  end

  def zero?
    @a_array.empty?
  end

  def transpose
    rows = to_a.transpose
    matrix = CSRMatrix.rows(rows)
    new_matrix matrix.a_array, matrix.ia_array, matrix.ja_array, matrix.row_count, matrix.column_count
  end

  def delete(row, col)
    raise(ArgumentError) unless row >= 0 && col >= 0

    rows = to_a
    rows[row][col] = 0
    matrix = CSRMatrix.rows(rows)
    @a_array = matrix.a_array
    @ia_array = matrix.ia_array
    @ja_array = matrix.ja_array
  end

  private

  def set_value(row, col, value)
    raise(ArgumentError) unless row >= 0 && col >= 0
    raise(TypeError) unless value.is_a?(Numeric) || value.nil?

    rows = to_a
    rows[row][col] = value
    matrix = CSRMatrix.rows(rows)
    @a_array = matrix.a_array
    @ia_array = matrix.ia_array
    @ja_array = matrix.ja_array
  end
end
