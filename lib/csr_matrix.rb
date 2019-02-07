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

  # TODO: can we override rows in the superclass?
  # the rows argument makes no sense in the context of sparse matrices
  def self.rows(rows, copy = true)
    return unless args.length.nonzero?

    a_array = []
    ia_array = [0]
    ja_array = []

    matrix = args[0]
    matrix.each do |row|
      nonzero_count = 0
      raise(TypeError) unless row.is_a?(Array)

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

  def read_all
    @a_array
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @a_array.map! { |base| base**exponent }
  end
end
