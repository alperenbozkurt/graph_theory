require 'byebug'

class Node
  attr_accessor :subs, :root

  def initialize(root, *subs)
    @subs = subs
    @root = root
  end

  def add_edge(node)
    unless @subs.include? node
      @subs << node
      node.add_edge(self)
    end
  end

  def to_s
    "Bu düğüm : " + self.root + "\n -> Komşuları ise " + subs.map(&:root).join(', ')
  end
end

a  = Node.new("A")
b  = Node.new("B")

a.add_edge(b)

puts sol.to_s
