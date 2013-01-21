module DataMapper
  module Relation

    # Graph representation of finalized relations
    #
    class Graph

      # The class used to represent nodes in the graph
      #
      # @example
      #
      #   Graph.node_class
      #
      # @return [Node]
      #
      # @api public
      def self.node_class
        Node
      end

      # The class used to represent edges in the graph
      #
      # @example
      #
      #   Graph.edge_class
      #
      # @return [Edge]
      #
      # @api public
      def self.edge_class
        Edge
      end

      # This graph's set of nodes
      #
      # @example
      #
      #   graph = Graph.new
      #   graph.nodes
      #
      # @return [Set<Node>]
      #
      # @api public
      attr_reader :nodes

      # This graph's set of edges
      #
      # @example
      #
      #   graph = Graph.new
      #   graph.edges
      #
      # @return [Set<Edge>]
      #
      # @api public
      attr_reader :edges

      # Relation node class that is used in this registry
      #
      # @example
      #
      #   DataMapper[Person].relations.node_class
      #
      # @return [Node]
      #
      # @api public
      attr_reader :node_class

      # Relation edge class that is used in this registry
      #
      # @example
      #
      #   DataMapper[Person].relations.edge_class
      #
      # @return [Edge]
      #
      # @api public
      attr_reader :edge_class

      # Connector hash
      #
      # @example
      #
      #   DataMapper[Person].relations.connectors
      #
      # @return [Hash]
      #
      # @api public
      attr_reader :connectors

      # Initialize a new relation registry object
      #
      # @param [Class] node_class
      #   the class used to construct nodes in the graph
      #
      # @param [Class] edge_class
      #   the class used to construct edges in the graph
      #
      # @return [undefined]
      #
      # @api private
      def initialize(node_class = self.class.node_class, edge_class = self.class.edge_class)
        @nodes      = Set.new
        @edges      = Set.new
        @node_class = node_class
        @edge_class = edge_class
        @connectors = {}
      end

      # Register a new connector
      #
      # @param [Connector]
      #
      # @return [self]
      #
      # @api private
      def add_connector(connector)
        @connectors[connector.name.to_sym] = connector
        self
      end

      # Add new relation node to the graph
      #
      # @return [self]
      #
      # @api private
      def new_node(*args)
        add_node(build_node(*args))
      end

      # Build a new node
      #
      # @param [String,Symbol,#to_sym] name
      #
      # @param [Veritas::Relation] relation
      #
      # @param [Aliases,nil] aliases
      #
      # @return [Node]
      #
      # @api private
      def build_node(*args)
        node_for(args[1]) || node_class.new(*args)
      end

      # Add a node to the graph
      #
      # @example
      #
      #   graph = Graph.new
      #   node  = Node.new(:node)
      #   graph = graph.add_node(node)
      #
      # @param [Node] node
      #   the node to add to the graph
      #
      # @return [self]
      #
      # @api public
      def add_node(node)
        @nodes << node
        self
      end

      # Add new relation edge to the graph
      #
      # @return [self]
      #
      # @api private
      def new_edge(*args)
        add_edge(build_edge(*args))
      end

      # Build a new edge
      #
      # @return [Edge]
      #
      # @api private
      def build_edge(*args)
        edge_for(args.first) || edge_class.new(*args)
      end

      # Add an edge to the graph
      #
      # @example
      #
      #   graph = Graph.new
      #   left  = Node.new(:left)
      #   right = Node.new(:right)
      #   graph.add_node(left)
      #   graph.add_node(right)
      #   edge  = Edge.new(:name, left, right)
      #   graph = graph.add_edge(edge)
      #
      # @param [Edge] edge
      #   the edge to add to the graph
      #
      # @return [self]
      #
      # @api public
      def add_edge(edge)
        @edges << edge
        self
      end

      # Add new relation node to the graph
      #
      # @param [Object] relation
      #   an instance of the engine's relation class
      #
      # @return [self]
      #
      # @api private
      def <<(relation)
        new_node(relation.name, relation)
      end

      # Return relation node with the given name
      #
      # @example
      #
      #   DataMapper.engines[:default].relations[:people]
      #
      # @param [Symbol] name of the relation
      #
      # @return [Node]
      #
      # @api public
      def [](name)
        name = name.to_sym
        @nodes.detect { |node| node.name == name }
      end

      # Return relation node for the given relation
      #
      # @param [Object] relation
      #   an instance of the engine's relation class
      #
      # @return [Node] if a node for the given relation exists
      # @return [nil] otherwise
      #
      # @api private
      def node_for(relation)
        self[relation.name.to_sym]
      end

      # Returns the edge with the given name
      #
      # @param [#to_sym] name
      #   the edge's name
      #
      # @return [Edge] if an edge with the given name exists
      # @return [nil] otherwise
      #
      # @api private
      def edge_for(name)
        edges.detect { |edge| edge.name.to_sym == name.to_sym }
      end

      # The header to use for automatic renaming when joining two nodes
      #
      # @see Node.header
      #
      # @param [*args] args
      #   the arguments accepted by {Node.header}
      #
      # @return [Header]
      #   the header for the passed in arguments
      #
      # @api private
      def header(*args)
        node_class.header(*args)
      end

    end # class Graph

  end # module Relation
end # module DataMapper
