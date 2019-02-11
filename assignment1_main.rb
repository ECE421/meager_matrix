# This Library was made by:
#
# Group 4:
#   Nathan Klapstein (1449872)
#   Tony Qian (1396109)
#   Thomas Lorincz (1461567)
#   Zach Drever (1446384)
#
# The runtime of different components is at worst the runtime of the
# matrix implementation of matrix.rb (the ruby standard library) plus
# the cost of matrix construction from sparse matrix formats.
#
# For sparse matrix implementations- depending on the data structure used
# to store the sparse matrix, the runtime is variable. For all implementation
# specific solutions, the runtime should be less than the standard matrix
# implementation. Our sparse matrix library primarily provides compressed
# storage for sparse matrices.
