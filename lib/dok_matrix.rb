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

  def self.rows(rows, column_count = rows[0].length)
    # compute into a dictionary
    row_count = rows.length
    dict = {}
    rows.each_with_index do |row, i|
      raise ArgumentError, "row size differs (#{row.size} should be #{column_count})" unless row.size == column_count

      row.each_with_index do |value, j|
        raise(TypeError) unless value.is_a?(Numeric)
        next unless value.nonzero?

        dict[[i, j]] = value
      end
    end
    new dict, row_count, column_count
  end

  def read_all
    @dict.values
  end

  def [](row, col)
    @dict.key?([row, col]) ? @dict[[row, col]] : 0
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

    super**other # rubocop:disable Layout/SpaceAroundKeyword
  end

  def *(other)
    case other
    when Numeric
      dict = @dict.transform_values { |v| v * other }
      new_matrix dict, @row_count, @column_count
    when Matrix
      super other
    else
      Matrix.raise NotImplementedError, '*', self.class, other.class
    end
  end

  def /(other)
    case other
    when Numeric
      dict = @dict.transform_values { |v| v / other }
      new_matrix dict, @row_count, @column_count
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

  def read(row, col)
    @dict[[row, col]]
  end

  def delete(row, col)
    raise(ArgumentError) unless row >= 0 && col >= 0

    @dict.delete([row, col])
  end

  def to_a
    array = Array.new(@row_count, Array.new(@column_count, 0))
    array.map!.with_index { |row, i| row.map.with_index { |_, j| self[i, j] } }
  end

  def to_matrix
    Matrix.rows(to_a)
  end

  def transpose
    new_dict = {}
    @dict.each do |key, val|
      new_dict[[key[1], key[0]]] = val
    end
    new_matrix new_dict, @column_count, @row_count
  end

  private def set_value(row, col, value)
    raise(ArgumentError) unless row >= 0 && col >= 0
    raise(TypeError) unless value.is_a?(Numeric) || value.nil?

    @dict[[row, col]] = value
  end
end
