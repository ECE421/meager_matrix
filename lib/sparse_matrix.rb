# Generic Sparse Matrix (CSR storage)
class SparseMatrix
    def initialize(nrows: Integer, ncols: Integer)
        @nnz = 0
        @num_rows = nrows
        @num_cols = ncols
        @a_array = Array.new # []
        @ia_array = Array.new(1, 0) # [0]
        @ja_array = Array.new # []
    end

    def initialize(matrix: Array)
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