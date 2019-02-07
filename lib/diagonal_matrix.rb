require_relative '../lib/sparse_matrix'

# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrix < SparseMatrix
  attr_reader :diagonal
  attr_reader :row_count
  attr_reader :column_count
  attr_reader :rows

  def initialize(rows, column_count = rows[0].size)
    rows = rows.to_a
    diagonal = []
    rows.each_with_index do |row, i|
      row = row

      num_col = row.length

      next if i >= num_col

      diagonal.push(row[i])
    end

    @diagonal = diagonal
    @column_count = column_count
    @row_count = rows.length
    @rows = Rows.new(self).to_enum.lazy
  end

  def to_a
    @rows.to_a
  end

  def to_matrix
    Matrix.rows(to_a)
  end

  #
  # Returns the DiagonalMatrix as a Matrix.
  #
  class Rows
    def initialize(parent)
      @parent = parent
    end
    def each
      i = 0
      while i < @parent.row_count
        row = Array.new(@parent.column_count, 0)
        if i < @parent.diagonal.length
          row[i] = @parent.diagonal.at(i)
        end
        yield row
        i += 1
      end
    end
  end

  #
  # quick and dirty optimizations go below here
  #
  def upper_triangular?
    true
  end

  def lower_triangular?
    true
  end
end

d = DiagonalMatrix.rows([[1, 0], [0, 2], [0, 0]])

puts(d.collect{ |e| e**2 }.to_a.to_s)
puts(d.transpose.to_a.to_s)
puts(d.to_a.to_s)
puts(d.upper_triangular?)
