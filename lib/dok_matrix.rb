require_relative '../lib/sparse_matrix'

# Dictionary Of Keys (DOK) sparse matrix
class DOKMatrix < SparseMatrix
  attr_reader(:dict)

  def initialize(rows, column_count = rows[0].size)
    @dict = {}
    @row_count = 0

    rows.each_with_index do |row, i|
      raise(TypeError) unless row.is_a?(Array)

      @row_count = row.length

      row.each_with_index do |value, j|
        raise(TypeError) unless value.is_a?(Numeric)
        next unless value.nonzero?

        @dict[:"#{i},#{j}"] = value
      end
    end
    @column_count = column_count
  end

  def row_count
    @row_count
  end

  def self.rows(rows, copy = true)
    rows = convert_to_array(rows, copy)
    rows.map! do |row|
      convert_to_array(row, copy)
    end
    size = (rows[0] || []).size
    rows.each do |row|
      raise ErrDimensionMismatch, "row size differs (#{row.size} should be #{size})" unless row.size == size
    end
    new rows, size
  end

  def read_all
    @dict.values
  end

  def [](i, j)
    @dict[:"#{i},#{j}"]
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

  def to_a
    i = 0
    array = Array.new(@row_count, Array.new(@column_count, 0))
    while i < @row_count
      row = Array.new(@column_count, 0)
      row.each_with_index do |_, j|
        row[j] = self[i, j]
      end
      array[i] = row
      puts(array)
      i += 1
    end
    array
  end
end
