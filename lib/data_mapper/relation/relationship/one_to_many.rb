module DataMapper
  module Relation
    class Relationship

      class OneToMany < self

        include CollectionBehavior

        # @see Options#default_target_key
        #
        def default_target_key
          [ self.class.foreign_key_name(source_model.name) ].freeze
        end
      end # class OneToMany
    end # class Relationship
  end # module Relation
end # module DataMapper
