# Generic Sparse Matrix (CSR storage)
class SparseMatrix
    public
    # Basic initialization. Assumes matrix input is properly formatted.
    def initialize(matrix: Array)
        @nnz = 0
        @num_rows = matrix.length
        @num_cols = matrix[0].length # TODO: Bad assumption
        @a_array = Array.new # []
        @ia_array = Array.new(1, 0) # [0]
        @ja_array = Array.new # []

        zero_count = 0
        matrix.each do |row|
            if row.is_a?(Array)
                row.each_with_index do |value, index|
                    if value == 0
                        zero_count += 1
                    else
                        @nnz += 1
                        @a_array.insert(@a_array.length, value)
                        @ia_array.insert(@ia_array.length, @ia_array[@ia_array.length - 1] + zero_count)
                        zero_count = 0
                        @ja_array.insert(@ja_array.length, index)
                    end
                end
            else
                TypeError
            end
        end
    end

    private
    def check_index(row: Integer, col: Integer)
        if row < 0 or row > @num_rows
            IndexError
        end
        if col < 0 or col > @num_cols
            IndexError
        end
    end

    public
    def get(row: Integer, col: Integer)
        self.check_index(row, col)
        # TODO
    end

    def insert(val: Float, row: Integer, col: Integer)
        self.check_index(row, col)
        # TODO
    end

    def remove(row: Integer, col: Integer)
        self.check_index(row, col)
        # TODO
    end

    def dot(other_matrix: SparseMatrix)
        # TODO
        self
    end

    def transpose
        # TODO
        self
    end
end