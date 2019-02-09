# Abstract Factory Superclass
class SparseMatrixFactory
  def self.build(source, type = CSRMatrixFactory.new)
    raise TypeError unless type.is_a?(SparseMatrixFactory)

    if source.is_a?(Matrix)
      type.build_from_matrix(source)
    elsif source.is_a?(Array)
      type.build_from_array(source)
    else
      raise TypeError
    end
  end

  protected

  def build_from_matrix(source_matrix) end

  def build_from_array(source_array) end
end
