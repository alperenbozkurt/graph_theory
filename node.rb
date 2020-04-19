require 'byebug'

class Node
  attr_accessor :edges, :root

  def initialize(root, *edges)
    @root = root
    @edges = edges
    @edges.each do |edge|
      edge.add_edge(self)
    end
  end

  def add_edge(node)
    unless @edges.include? node
      @edges << node
      node.add_edge(self)
    end
  end

  def to_s
    "Bu düğüm : " + self.root + "\n -> Komşuları ise: " + edges.map(&:root).join(', ')
  end
end

# a  = Node.new("A")        # A düğümünü oluştur
# b  = Node.new("B", a)     # B nodunu oluştur ve a düğümü ile bağla
# c  = Node.new("C")        # C düğümünü oluştur

# c.add_edge(b)             # C düğümü ile a düğümünü bağla

# puts a.to_s
# puts b.to_s
# puts c.to_s
