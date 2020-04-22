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

  def self.create_wheel_graph(node_count)
    nodes = []
    node_count.times do |count|
      nodes << Node.new(count.to_s)
    end
    graph = Graph.new(nodes)
    nodes.each_with_index do |node, index|
      if index > 0
        graph.add_edge_from_index(index, index - 1);
        graph.add_edge_from_index(0, index);
      end
    end
    graph.add_edge_from_index(1, nodes.count - 1);
    return graph
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

  def fix_edges
    nodes.each do |node|
      node.fix_edges
    end
  end

  def include?(node)
    nodes.map(&:root).include? node.root
  end

  def find(node)
    nodes.each do |nodex|
      if nodex.root == node.root
        return nodex
      end
    end
    return nil
  end

  def dfs(root_node, visited_nodes=nil, tree=nil)
    is_root_node = false
    if visited_nodes.nil?
      tree = Graph.new
      is_root_node = true
      visited_nodes = nodes.zip(Array.new(nodes.count, 0)).to_h
    end
    new_root_node = tree.find(root_node)
    unless new_root_node
      new_root_node = Node.new(root_node.root)
      tree.add_node(new_root_node)
    end

    visited_nodes[root_node] = 1

    root_node.neighbors.each do |neighbor|
      if visited_nodes[neighbor].zero?
        new_node = Node.new(neighbor.root)
        tree.add_node(new_node)
        tree.add_edge(new_node, new_root_node)
        visited_nodes, tree = dfs(neighbor, visited_nodes, tree)
      end
    end
    return is_root_node ? tree : [visited_nodes, tree]
  end

  def bfs(root_node, visited_nodes = nil, tree=nil)
    is_root_node = false
    if visited_nodes.nil?
      tree = Graph.new
      is_root_node = true
      visited_nodes = nodes.zip(Array.new(nodes.count, 0)).to_h
    end
    new_root_node = tree.find(root_node)
    unless new_root_node
      new_root_node = Node.new(root_node.root)
      tree.add_node(new_root_node)
    end
    visited_nodes[root_node] = 1

    root_node.neighbors.each do |neighbor|
      if visited_nodes[neighbor].zero?
        puts(" Yeni Düğüm oluşturuluyor : " + neighbor.root)
        new_node = Node.new(neighbor.root)
        tree.add_node(new_node)
        tree.add_edge(new_node, new_root_node)
      end
    end
    root_node.neighbors.each do |neighbor|
      if visited_nodes[neighbor].zero?
        visited_nodes, tree = bfs(neighbor, visited_nodes, tree)
      end
    end
    return is_root_node ? tree : [visited_nodes, tree]
  end

  def euler_path?
    nodes.sum(&:edges_count).even?
  end

  def euler_path
    gezilen = []
    yollar = []
    nodes.each do |node|
      node.neighbors.each do |neighbor|
        if yollar.include?((node.root + ',' + neighbor.root)) || yollar.include?((neighbor.root + ',' + node.root))
          "s"
        else
          yollar << (node.root + "," + neighbor.root)
        end
      end
    end

    devam, bitti = false, false
    nodes.each do |node|
      root_node = node
      100.times do
        until yollar.empty?
          new_root = root_node.neighbors.sample
          if yollar.include?((root_node.root + ',' + new_root.root)) || yollar.include?((new_root.root + ',' + root_node.root))
            gezilen << root_node
            # puts (root_node.root + ',' + new_root.root)
            if yollar.include?((root_node.root + ',' + new_root.root))
              yollar.delete((root_node.root + ',' + new_root.root).to_s)
            else
              yollar.delete((new_root.root + ',' + root_node.root).to_s)
            end
            root_node = new_root
            # puts yollar.count
          end
          devam = false
          root_node.neighbors.each do |neighbor|
            if yollar.include?(root_node.root + ',' + neighbor.root)
              devam = true
            end
          end
          if !devam
            if yollar.count == 0
              puts gezilen.map(&:root).join(", ")
            end
            break
          end
        end
      end
    end
    return yollar
  end

  def hammiltion_path
    dugumler = nodes
    path = []
    puts dugumler.count
    nodes.each do |node|
      dugumler = nodes
      path = []
      devamke = false
      root_node = node
      # puts dugumler.count
      100.times do |i|
        until dugumler.empty?
          new_root = root_node.neighbors.sample
          if dugumler.include?(new_root)
            # puts new_root.root + ', ' + dugumler.count.to_s
            path << new_root
            dugumler.delete(new_root)
            root_node = new_root
          end
          devamke = false
          root_node.neighbors.each do |neighbor|
            if dugumler.include?(neighbor)
              devamke = true
            end
          end
          if !devamke
            if dugumler.count == 0
              return path.map(&:root).join(", ")
            else
              break
            end
          end
        end
      end
    end
    return nil
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

# ---------------------------------------------------------------------

# g3 = Graph.create_wheel_graph(6)    # root düğüm ile birlikte 6 düğümü olan bir tekerlek graf oluşturur
# puts g3.adjoint_matrix, ""

# root_node = g3.nodes[0]             # dfsnin başlangıç düğümünü seçiyoruz
# dfs_tree = g3.bfs(root_node)        # grafı dfs algoritması ile ağaca çevirir.
# dfs_tree.adjoint_matrix             # dfs ağacının adjoint matrisini verir

# --------------------------------------------------------------------

# g4 = Graph.create_wheel_graph(7)    # root düğüm ile birlikte 6 düğümü olan bir tekerlek graf oluşturur
# puts g4.adjoint_matrix, ""

# g4.euler_path?
# g4.euler_path

# --------------------------------------------------------------------

g5 = Graph.create_wheel_graph(7)
puts g5.hammiltion_path
