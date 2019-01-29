# Compressed Sparse Row (CSR) sparse matrix
class CSRMatrix < Matrix
  attr_reader(:a_array, :ia_array, :ja_array)

  # Basic initialization. Assumes matrix input is properly formatted.
  def initialize(*args)
    @a_array = []
    @ia_array = [0]
    @ja_array = []

    return unless args.length.nonzero?

    matrix = args[0]
    matrix.each do |row|
      nonzero_count = 0
      raise(TypeError) unless row.is_a?(Array)

      row.each_with_index do |value, index|
        next unless value.nonzero?

        nonzero_count += 1
        @a_array.insert(@a_array.length, value)
        @ja_array.insert(@ja_array.length, index)
      end
      @ia_array.insert(@ia_array.length,
                       @ia_array[@ia_array.length - 1] + nonzero_count)
    end
  end

  def read_all
    @a_array
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @a_array.map! { |base| base**exponent }
  end
end
