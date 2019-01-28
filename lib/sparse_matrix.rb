# Abstract factory for building sparse matrix
class SparseMatrix
  def initialize(*args)
    raise(ArgumentError) unless args.length == 2

    raw_data = args[0]
    type = args[1]
    if type == 'csr'
      @matrix = CSRMatrix.new(raw_data)
    elsif type == 'dok'
      @matrix = DOKMatrix.new(raw_data)
    else
      raise(ArgumentError, "Unknown type #{type}")
    end
  end

  def read_all!
    @matrix.read_all
  end

  def power!(exponent)
    @matrix.power(exponent)
  end
end
