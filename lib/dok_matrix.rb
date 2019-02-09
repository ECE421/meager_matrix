require_relative '../lib/sparse_matrix'

# Dictionary Of Keys (DOK) sparse matrix
class DOKMatrix < SparseMatrix
  attr_reader(:dict)

  def initialize(*args)
    @dict = {}

    return unless args.length.nonzero?
    raise(TypeError) unless args[0].is_a?(Array)

    matrix = args[0]
    matrix.each_with_index do |row, i|
      raise(TypeError) unless row.is_a?(Array)

      row.each_with_index do |value, j|
        raise(TypeError) unless value.is_a?(Numeric)
        next unless value.nonzero?

        @dict[:"#{i},#{j}"] = value
      end
    end
  end

  def self.rows(rows, column_count = rows[0].length)
    # TODO: Implement
  end

  def read_all
    @dict.values
  end

  def read(row, col)
    @dict[:"#{row},#{col}"]
  end

  def insert(row, col, value)
    raise(ArgumentError) unless row >= 0 && col >= 0
    raise(TypeError) unless value.is_a?(Numeric) || value.nil?
    return delete(row, col) unless !value.nil? && value.nonzero?

    @dict[:"#{row},#{col}"] = value
  end

  def delete(row, col)
    raise(ArgumentError) unless row >= 0 && col >= 0

    @dict.delete(:"#{row},#{col}")
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @dict.transform_values! { |base| base**exponent }
  end
end
