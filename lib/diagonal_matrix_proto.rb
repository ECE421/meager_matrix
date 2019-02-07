require_relative '../lib/sparse_matrix'

# A Diagonal Sparse Matrix
# A sparse matrix that only contains non-zero values within the main diagonal.
# With this knowledge heavy optimizations can be done.
class DiagonalMatrixProto < SparseMatrix
  attr_reader :diagonal
  attr_reader :rows

  def initialize(rows, column_count = rows[0].size)
    puts('new')
    puts(rows.to_a.to_s)
    self.instance_variable_set("@rows", Rows.new(self))

    diagonal = []
    rows.each_with_index do |row, i|
      row = row

      num_col = row.length

      next if i >= num_col

      diagonal.push(row[i])
    end

    @diagonal = diagonal
    @row_count = rows.size
    @column_count = column_count
    @rows = to_a.to_enum.lazy
  end

  class Rows < Array
    def initialize(parent)
      @parent = parent
    end

    def Array.self
      @parent.to_a
    end
    def transpose()

      puts('ta')
      puts(@parent.to_a)

      @parent.to_a.transpose
    end

    def fetch(i)
      @parent.to_a.fetch(i)
    end

    def []=
      @parent.diagonal
    end

    def each(&block)
      @parent.to_a.each(&block)
    end

    def to_enum
      @parent.to_a.to_enum
    end

    def collect(&block)
      @parent.to_a.collect(&block)
    end

    def size
      @parent.to_a.size
    end

  end

  # Initialize a diagonal sparse matrix from a array based definition
  # Note: non diagonal values will be dropped

  # TODO: make Matrix.build

  def self.diagonal(*values)
    new values, values.size
  end

  # Returns the DiagonalMatrix as a Matrix.
  #
  def to_matrix
    Matrix.rows(to_a)
  end

  def to_a
    i = 0
    matrix = Array.new(@row_count, Array.new(@column_count, 0))
    while i < @diagonal.length
      row = Array.new(@column_count, 0)
      row[i] = diagonal.at(i)
      matrix[i] = row
      i += 1
    end
    matrix
  end
end
d = DiagonalMatrixProto.rows([[1, 0], [0, 2], [0, 0]])
# puts(d[1, 2])
# puts(d[0, 2])
# puts(d[0,0])
# puts(d[1, 1])
# puts(d.diagonal)
# puts(d.to_a)
# puts(d.to_a.to_s)
# d.each{|e| puts e+100}
#
#
# puts(d.collect{ |e| e**2 }.to_a.to_s)
puts(d.transpose.to_a.to_s)