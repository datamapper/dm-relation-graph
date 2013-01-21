# -*- encoding: utf-8 -*-
require File.expand_path('../lib/data_mapper/relation/graph/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "dm-relation-graph"
  gem.description   = "dm-relation-graph"
  gem.summary       = "dm-relation-graph"
  gem.authors       = [ 'Martin Gamsjaeger (snusnu)', 'Piotr Solnica' ]
  gem.email         = %w[ gamsnjaga@gmail.com piotr.solnica@gmail.com ]
  gem.homepage      = 'http://datamapper.org'
  gem.require_paths = %w[ lib ]
  gem.version       = DataMapper::Relation::Graph::VERSION
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")

  gem.add_dependency 'equalizer',           '~> 0.0.3'
  gem.add_dependency 'descendants_tracker', '~> 0.0.1'
  gem.add_dependency 'abstract_type',       '~> 0.0.2'
  gem.add_dependency 'mbj-inflector',       '~> 0.0.2'
  gem.add_dependency 'adamantium',          '~> 0.0.5'
  #gem.add_dependency 'veritas',             '~> 0.0.7'
end
