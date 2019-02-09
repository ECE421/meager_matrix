require_relative '../lib/sparse_matrix'

# Compressed Sparse Row (CSR) sparse matrix
class CSRMatrix < SparseMatrix
  attr_reader(:a_array, :ia_array, :ja_array, :row_count, :column_count)

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

  def to_a
    array = Array.new(@row_count) { Array.new(@column_count, 0) }
    a_index = 0
    last_num = 0
    @ia_array.each_with_index do |num, i|
      num_in_row = num - last_num
      (0..num_in_row - 1).each do |_|
        array[i - 1][@ja_array[a_index]] = @a_array[a_index]
        a_index += 1
      end
      last_num = num
    end
    array
  end

  def to_matrix
    Matrix.rows(to_a)
  end
end
