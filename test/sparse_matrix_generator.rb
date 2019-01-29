class TestMatrixGenerator

  def self.generate_sparse_matrix(rows, cols, ratio:0.5, rand_max:10)
    # Generate a random general sparse matrix with non-zero element ratio < ratio
    arr = Array.new(rows, Array.new(cols, 0))
    arr.map!{|row| row.map{ rand < ratio ? rand(rand_max) : 0}}

    return arr
  end

  def self.generator_diag_matrix(rows, cols, band_width:1, band_offset:0, rand_max:10)
    # Generate random band matrices
    arr = []
    rows.times do |n|
      s = n + band_offset > 0 ? n + band_offset : 0
      e = n + band_offset + band_width > 0 ? n + band_offset + band_width : 0
      arr << Array.new(cols, 0).map!.with_index {|elem, i| (i >= s && i < e) ? rand(rand_max): 0}
    end
    return arr
  end

end