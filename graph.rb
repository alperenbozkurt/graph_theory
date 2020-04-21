load "./node.rb"

class Graph
  attr_accessor :nodes

  def initialize(*nodes)
    # Nodes iç içe array olarak gelirse içerdeki arraydekileri ekle
    @nodes = nodes[0].is_a?(Array) ? nodes[0] : nodes
  end

  def self.create_null_graph(node_count)  # n elemanlı boş bir graf oluşturur.
    nodes = []
    node_count.times do |count|           # n kere döner
      nodes << Node.new(count.to_s)       # n tane node oluşturur
    end

    return Graph.new(nodes)           # Oluşturulan node'larla bir graf oluşturup return eder.
  end

  def add_node(node)        # Grafa ekstra node eklenmek istenirse kullanılır.
    nodes << node
  end

  def add_nodes(*nodes)      # Birden fazla node eklenmek istenirse kullanılabilir
    nodes.each do |node|
      @node << node
    end
  end

  def add_edge(node1, node2) # iki node birbirine bağlanmak istenirse kullanılır.
    node1.add_edge(node2)    # bu işlem Node sınıfında halledilir.
  end

  def add_edge_from_index(index_node1, index_node2)
    nodes[index_node1].add_edge(nodes[index_node2])
  end

  def adjoint_matrix        # Komşuluk matrix'ini string olarak veren methoddur.
    matrix = ""
    nodes.each_with_index do |node, index|
      nodes.each_with_index do |other_node, other_index|
        is_neighbor = node.neighbor?(other_node)
        matrix << (is_neighbor ? "1 " : "0 ")
      end
      matrix << "\n"
    end
    return matrix
  end


  def dfs(root_node, visited_nodes=nil, tree=nil)
    if visited_nodes.nil?
      tree = Graph.new
      visited_nodes = nodes.zip(Array.new(nodes.count, 0)).to_h
      tree.add_node(Node.new(root_node.root))
    end

    visited_nodes[root_node] = 1

    root_node.neighbors.each do |neighbor|
      if visited_nodes[neighbor].zero?
        visited_nodes, tree = dfs(neighbor, visited_nodes, tree)
        node = Node.new(neighbor.root)
        neighbor = tree.add_node(node)
        tree.add_edge(root_node, neighbor)
      end
    end
    return visited_nodes, tree
  end
end


# g = Graph.create_null_graph(5)      # 5 nodu olan boş bir graf oluşturur.
# puts g.nodes                        # Ekrana graftaki bütün nodeları ve komşularını yazdırır.

# g2 = Graph.new                      # Yeni bir graf oluşturur

# n1 = Node.new("A")                  # Yeni bir node oluşturur
# n2 = Node.new("B")                  # Yeni bir node oluşturur

# g2.add_node(n1)                     # Grafa node ekler
# g2.add_node(n2)                     # Grafa node ekler

# g2.add_edge(n1, n2)                 # Grata iki node arasına bir edge oluşturmak için kullanılır.

# puts n1.neighbor? n2                # N1 düğümü ile n2 düğümü komşu mu ?

# puts g2.nodes                       # Ekrana graftaki bütün nodeları ve komşularını yazdırır.

# puts g2.adjoint_matrix              # g2 grafının komşuluk matrisini string olarak verir.

g3 = Graph.create_null_graph(6)

g3.add_edge_from_index(1,2);
g3.add_edge_from_index(2,3);
# g3.add_edge_from_index(3,4);
g3.add_edge_from_index(4,5);
g3.add_edge_from_index(1,5);

g3.add_edge_from_index(0,1);
g3.add_edge_from_index(0,2);
g3.add_edge_from_index(0,3);
g3.add_edge_from_index(0,4);
g3.add_edge_from_index(0,5);

puts g3.adjoint_matrix

root_node = g3.nodes[0]
a = g3.dfs(root_node)
puts a[1].nodes
