module DataMapper
  module Relation

    # RelationshipSet scoped to a single {Mapper}
    #
    # Since set uniqueness is based on {Relationship#name}
    # it is not safe to store relationships from more than
    # one {Mapper} in instances of this class.
    #
    # @api private
    class RelationshipSet
      include Enumerable

      # @api private
      def initialize(entries = nil)
        @entries = {}
        merge(entries || [])
      end

      # @api private
      def each
        return to_enum unless block_given?
        @entries.each_value { |entry| yield(entry) }
        self
      end

      # @api private
      def <<(entry)
        @entries[entry.name] = entry
        self
      end

      # @api private
      def [](name)
        @entries[name]
      end

      private

      # @api private
      def merge(other)
        other.each { |entry| self << entry }
        self
      end
    end # class RelationshipSet
  end # module Relation
end # module DataMapper
