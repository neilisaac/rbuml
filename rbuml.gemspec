Gem::Specification.new do |s|
  s.name        = 'rbuml'
  s.version     = '0.1.0'
  s.date        = '2016-01-09'
  s.summary     = "rbuml is a uml dsl for ruby for generating class diagrams"
  s.description = "rbuml provides classes and a dsl for representing uml class relationships " \
                  "that can be rendered as a uml class diagram using graphviz dot"
  s.authors     = ["Neil Isaac"]
  s.email       = 'mail@neilisaac.ca'
  s.files       = ["lib/rbuml.rb", "lib/rbuml/models.rb", "lib/rbuml/dot.rb", "lib/rbuml/dsl.rb", "bin/rbuml"]
  s.executables << "rbuml"
  s.add_runtime_dependency "ruby-graphviz", "~> 1.2"
  s.homepage    =
    'https://github.com/neilisaac/rbuml'
  s.license       = 'MIT'
end
