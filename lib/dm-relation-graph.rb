module DataMapper

  # Raised when the returned tuples are unexpectedly empty
  NoTuplesError = Class.new(RuntimeError)

  # Raised when the returned tuples are unexpectedly too many
  ManyTuplesError = Class.new(RuntimeError)

  # Represent an undefined argument
  Undefined = Object.new.freeze

  # An empty frozen Hash useful for parameter default values
  EMPTY_HASH = Hash.new.freeze

  # Represent a positive, infinitely large Float number
  Infinity  = 1.0 / 0

end # module DataMapper

require 'abstract_type'
require 'adamantium'
require 'equalizer'
require 'inflector'

require 'data_mapper/relationship'
require 'data_mapper/relationship/join_definition'
require 'data_mapper/relationship/via_definition'
require 'data_mapper/relationship/collection_behavior'
require 'data_mapper/relationship/iterator'
require 'data_mapper/relationship/iterator/tuples'
require 'data_mapper/relationship/one_to_many'
require 'data_mapper/relationship/one_to_one'
require 'data_mapper/relationship/many_to_one'
require 'data_mapper/relationship/many_to_many'
require 'data_mapper/relationship/builder/belongs_to'
require 'data_mapper/relationship/builder/has'

require 'data_mapper/relation/header'
require 'data_mapper/relation/header/attribute_index'
require 'data_mapper/relation/header/relation_index'
require 'data_mapper/relation/header/attribute'
require 'data_mapper/relation/header/join_strategy'
require 'data_mapper/relation/header/join_strategy/natural_join'
require 'data_mapper/relation/header/join_strategy/inner_join'
require 'data_mapper/relation/graph'
require 'data_mapper/relation/graph/node'
require 'data_mapper/relation/graph/node/name'
require 'data_mapper/relation/graph/node/name_set'
require 'data_mapper/relation/graph/edge'
require 'data_mapper/relation/graph/connector'
require 'data_mapper/relation/graph/connector/builder'
