module SpecHelper

  def self.draw_relation_registry(file_name = 'graph.png')
    require 'graphviz'

    # Create a new graph
    g = GraphViz.new( :G, :type => :digraph )

    relation_registry = DataMapper.engines[:postgres].relations

    map = {}

    relation_registry.nodes.each do |relation_node|
      node = g.add_nodes(relation_node.name.to_s)
      map[relation_node] = node
    end

    relation_registry.edges.each do |edge|
      source = map[edge.left]
      target = map[edge.right]

      g.add_edges(source, target, :label => edge.name.to_s)
    end

    relation_registry.connectors.each do |name, connector|
      source = map[connector.source_node]
      target = map[connector.node]

      relationship = connector.relationship

      label = "#{relationship.source_model}##{relationship.name} [#{name}]"

      g.add_edges(source, target, :label => label, :style => 'bold', :color => 'blue')
    end

    # Generate output image
    g.output( :png => file_name )
  end

  def subclass(name = nil)
    Class.new(described_class) do
      define_singleton_method(:name) { "#{name}" }
      yield if block_given?
    end
  end

  def mock_relation(name, header = [], tuples = Veritas::Relation::Empty::ZERO_TUPLE)
    Veritas::Relation::Base.new(name, header, tuples)
  end

  def mock_relationship(name, attributes = {})
    Relationship::OneToMany.new(name, attributes[:source_model], attributes[:target_model], attributes)
  end

  def mock_connector(attributes)
    OpenStruct.new(attributes)
  end

  def mock_node(name)
    OpenStruct.new(:name => name)
  end

  def mock_join_definition(left_relation, right_relation, left_keys, right_keys)
    left  = Relationship::JoinDefinition::Side.new(left_relation,  left_keys)
    right = Relationship::JoinDefinition::Side.new(right_relation, right_keys)
    Relationship::JoinDefinition.new(left, right)
  end

  def attribute_alias(*args)
    DataMapper::Relation::Header::Attribute.build(*args)
  end

end
