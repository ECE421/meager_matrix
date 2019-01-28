# Dictionary Of Keys (DOK) sparse matrix
class DOKMatrix
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

  def power(exponent)
    raise(TypeError) unless exponent.is_a?(Numeric)

    @dict.transform_values! { |base| base**exponent }
  end
end
