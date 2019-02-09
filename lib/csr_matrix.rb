require_relative '../lib/sparse_matrix'

# Compressed Sparse Row (CSR) sparse matrix
class CSRMatrix < SparseMatrix
  attr_reader(:a_array, :ia_array, :ja_array)

  # Basic initialization. Assumes matrix input is properly formatted.
  def initialize(a_array, ia_array, ja_array)
    @a_array = a_array
    @ia_array = ia_array
    @ja_array = ja_array
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
    new a_array, ia_array, ja_array
  end

  #
  # Returns the CSRMatrix as a Matrix.
  #
  def to_matrix
  end

  def read_all
    @a_array
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @a_array.map! { |base| base**exponent }
  end
end
