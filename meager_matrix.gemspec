require 'rake'

Gem::Specification.new do |s|
  s.name = 'meager_matrix'
  s.version = '0.0.0'
  s.licenses = ['MIT']
  s.summary = 'A ruby sparse matrix library'
  s.description = "A ruby sparse matrix library that takes
inspiration from SciPy's implementation of sparse matrices."
  s.authors = ['Nathan Klapstein', 'Thomas Lorincz']
  s.email = 'nklapste@ualberta.ca'
  s.files = FileList['lib/*.rb', 'bin/*', 'spec/*.rb'].to_a
  s.homepage = 'https://github.com/ECE421/meager_matrix'
end
