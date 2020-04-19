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

    return Graph.new(nodes.map)           # Oluşturulan node'larla bir graf oluşturup return eder.
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
end


# g = Graph.create_null_graph(5)      # 5 nodu olan boş bir graf oluşturur.
# puts g.nodes                        # Ekrana graftaki bütün nodeları ve komşularını yazdırır.

# g2 = Graph.new                      # Yeni bir graf oluşturur

# n1 = Node.new("A")                  # Yeni bir node oluşturur
# n2 = Node.new("B")                  # Yeni bir node oluşturur

# g2.add_node(n1)                     # Grafa node ekler
# g2.add_node(n2)                     # Grafa node ekler

# g2.add_edge(n1, n2)                 # Grata iki node arasına bir edge oluşturmak için kullanılır.

# puts g2.nodes                       # Ekrana graftaki bütün nodeları ve komşularını yazdırır.
