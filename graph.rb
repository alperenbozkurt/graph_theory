load "./node.rb"

class Graph
  attr_accessor :nodes
  def initialize(*nodes)
    if nodes[0].is_a? Array
      @nodes = []
      nodes[0].each do |node|
        @nodes << node
      end
    else
      @nodes = nodes
    end
  end

  def self.create_null_graph(node_count)
    nodes = []
    node_count.times do |count|
      nodes << Node.new(count.to_s)
    end

    return Graph.new(nodes)
  end

  def add_node(node)
    nodes << node
  end

  def add_nodes(nodes)
    nodes.each do |node|
      @node << node
    end
  end

  def add_edge(node1, node2)
    node1.add_edge(node2)
  end
end


# g = Graph.create_null_graph(5)
# puts g.nodes

g2 = Graph.new

n1 = Node.new("A")
n2 = Node.new("B")

g2.add_node(n1)
g2.add_node(n2)

g2.add_edge(n1, n2)

puts g2.nodes
