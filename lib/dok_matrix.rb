# Dictionary Of Keys (DOK) sparse matrix
class DOKMatrix
  attr_reader(:dict)

  def initialize(*args)
    @dict = {}

    return unless args.length.nonzero?

    matrix = args[0]
    matrix.each_with_index do |row, i|
      raise(TypeError) unless row.is_a?(Array)

      row.each_with_index do |value, j|
        next unless value.nonzero?

        @dict[:"#{i},#{j}"] = value
      end
    end
  end

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @dict.transform_values! { |base| base**exponent }
  end
end
