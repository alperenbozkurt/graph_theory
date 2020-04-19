require 'byebug'

class Node
  attr_accessor :edges, :root

  def initialize(root, *edges)    # Node oluşturulurken ismi ve kenarları alınır.
    @root = root
    @edges = edges
    @edges.each do |edge|
      edge.add_edge(self)
    end
  end

  def add_edge(node)              # kenar yoksa eklenmesi için bu method kullanılır.
    unless @edges.include? node
      @edges << node
      node.add_edge(self)         # diğer node sınıfını günceller.
    end
  end

  def to_s      # Düğümü ve komşularını yazdırmak için kullanılan method
    "Bu düğüm : " + self.root + "\n -> Komşuları ise: " + edges.map(&:root).join(', ')
  end
end

# a  = Node.new("A")        # A düğümünü oluştur
# b  = Node.new("B", a)     # B nodunu oluştur ve a düğümü ile bağla
# c  = Node.new("C")        # C düğümünü oluştur

# c.add_edge(b)             # C düğümü ile a düğümünü bağla

# puts a.to_s
# puts b.to_s               # Düğümleri ve komşuları ekrana bastırır.
# puts c.to_s
