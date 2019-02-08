require 'matrix'
require_relative '../lib/sparse_matrix'

# Dictionary Of Keys (DOK) sparse matrix
class DOKMatrix < SparseMatrix
  attr_reader(:dict)

  def new_matrix(dict, row_count, column_count) # :nodoc:
    self.class.send(:new, dict, row_count, column_count) # bypass privacy of Matrix.new
  end

  def initialize(dict, row_count, column_count)
    @dict = dict
    @row_count = row_count
    @column_count = column_count
  end

  def row_count # rubocop:disable  Style/TrivialAccessors
    @row_count
  end

  def self.rows(rows, copy = true)
    # array conversion
    rows = rows.to_a

    # compute into a dictionary
    row_count = rows.length
    column_count = (rows[0] || []).size
    dict = {}
    rows.each_with_index do |row, i|
      raise ArgumentError, "row size differs (#{row.size} should be #{column_count})" unless row.size == column_count

      row.each_with_index do |value, j|
        raise(TypeError) unless value.is_a?(Numeric)
        next unless value.nonzero?

        dict[:"#{i},#{j}"] = value
      end
    end
    new dict, row_count, column_count
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

  def **(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @dict.transform_values { |base| base**exponent }
  end

  def *(rhs)
    if rhs.is_a? (Numeric)
      new(
        @dict.transform_values { |base| base * rhs },
        @row_count,
        @column_count
      )
    elsif rhs.is_a? (Matrix)
      super rhs
    end
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

  def to_matrix
    Matrix.rows(to_a)
  end

  def transpose
    new_dict = {}
    @dict.each do |key, val|
      coords = key.to_s.split(',')
      row = coords[1].to_i
      col = coords[0].to_i
      new_dict[:"#{row},#{col}"] = val
    end
    new_matrix new_dict, @column_count, @row_count
  end
end
