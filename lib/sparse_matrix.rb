# Generic Sparse Matrix (CSR storage)
class SparseMatrix
  attr_reader(:num_rows, :num_cols, :a_array, :ia_array, :ja_array)

  # Basic initialization. Assumes matrix input is properly formatted.
  def initialize(matrix)
    @num_rows = matrix.length
    @num_cols = matrix[0].length # TODO: Bad assumption
    @a_array = []
    @ia_array = [0]
    @ja_array = []

    matrix.each do |row|
      nonzero_count = 0
      if row.is_a?(Array)
        row.each_with_index do |value, index|
          if value.zero?
            next
          else
          nonzero_count += 1
          @a_array.insert(@a_array.length, value)
          @ja_array.insert(@ja_array.length, index)
          end
        end
      else
        TypeError
      end
      @ia_array.insert(@ia_array.length, @ia_array[@ia_array.length - 1] + nonzero_count)
    end
  end

  private

  def check_index(row, col)
    IndexError if row < 0 || row > @num_rows
    IndexError if col < 0 || col > @num_cols
  end
end
