require 'matrix'

class SparseMatrixGenerator
  def self.generate_sparse_matrix(
      rows,
      cols,
      ratio: 0.3,
      rand_max: 10
    )
    # Generate a random general sparse matrix with non-zero element
    # ratio < ratio
    arr = Array.new(rows, Array.new(cols, 0))
    arr.map! { |row| row.map { rand < ratio ? rand(rand_max) : 0 } }
    Matrix.rows(arr)
  end

  def self.generate_diag_matrix(
      rows,
      cols,
      band_width: 1,
      band_offset: 0,
      rand_max: 10
    )
    # Generate random band matrices
    arr = []
    rows.times do |n|
      s = (n + band_offset).positive? ? n + band_offset : 0
      e = (n + band_offset + band_width).positive? ? n + band_offset + band_width : 0
      arr << Array.new(cols, 0).map!.with_index do |_elem, i|
        i >= s && i < e ? rand(rand_max) : 0
      end
    end
    Matrix.rows(arr)
  end
end
