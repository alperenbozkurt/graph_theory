# Graf Teorisi
Graf Teorisi Dersi için yazdığım Graf Kütüphanesi bfs, dfs, euler path, hammiltion path gibi methodlara sahiptir.

### Node
Yeni bir düğüm oluşturmak için veya yol oluşturmak için kullanılabilir.

###### Yeni Bir Düğüm Oluşturmak
```ruby
a  = Node.new("A")        # A düğümünü oluştur
b  = Node.new("B", a)     # B nodunu oluştur ve B düğümüne giden bir yol oluştur
c  = Node.new("C")        # C düğümünü oluştur
d  = Node.new("D", a, b,c)# B nodunu oluştur ve B, C ve D düğümüne giden birer yol oluştur
```
###### Yeni Bir Yol Oluşturmak
```ruby
c.add_edge(b)             # C düğümü ile B düğümü arasında bir yol oluşturur.  
```

###### Düğümleri ve Komşularını Ekranda Göstermek
```ruby
puts b.to_s               # B düğümünü ve komşularını ekrana bastırır.
```

### Graflar
İçerisinde düğümler olan grafların işlemleri için kullanılır.

###### Yeni Bir Graf Oluşturmak

```ruby
g1 = Graph.new                       # Yeni bir boş graf oluşturur
g2 = Graph.create_null_graph(5)      # 5 nodu olan bir graf oluşturur.
puts g2.nodes                        # Ekrana graftaki bütün nodeları ve komşularını yazdırır.
g3 = Graph.create_wheel_graph(6)    # root düğüm ile birlikte 6 düğümü olan bir wheel graf oluşturur
```

###### Grafa Node Eklemek
```ruby
n1 = Node.new("A")                  # Yeni bir node oluşturur
n2 = Node.new("B")                  # Yeni bir node oluşturur

g1.add_node(n1)                     # Grafa node ekler
g1.add_node(n2)                     # Grafa node ekler
```

###### Grafdaki Nodelar Arasına Yol Eklemek
```ruby
g1.add_edge(n1, n2)                 # Grata iki node arasına bir yol oluşturmak için kullanılır.

puts n1.neighbor? n2                # n1 düğümü ile n2 düğümü komşu mu ?
# True
```

###### Komşuluk Matrisini Yazdırmak
```ruby
puts g2.adjoint_matrix              # g2 grafının komşuluk matrisini string olarak verir.
```

###### Grafı DFS İle Doşalmak
```ruby
root_node = g3.nodes[0]             # dfsnin başlangıç düğümünü seçiyoruz
dfs_tree = g3.dfs(root_node)        # grafı dfs algoritması ile ağaca çevirir.
dfs_tree.adjoint_matrix             # dfs ağacının adjoint matrisini verir
```

###### Grafı BFS İle Doşalmak
```ruby
root_node = g3.nodes[0]             # bfsnin başlangıç düğümünü seçiyoruz
bfs_tree = g3.bfs(root_node)        # grafı bfs algoritması ile ağaca çevirir.
bfs_tree.adjoint_matrix             # bfs ağacının adjoint matrisini verir
```
###### Grafın Euler Path'ini Yazdırmak
```ruby
g3.euler_path?                      # Grafta Euler pathinin olup olmadığını boolean olarak verir
# True
g3.euler_path                       # Grafta euler path bulunuyorsa pathi array olarak döndürür. Bulunmuyorsa nil döndürür.
# [3,4,0,2,1,6,5]
```
###### Grafın Hammiltion Path'ini Yazdırmak
```ruby
g3.hammiltion_path?                 # Grafta Euler pathinin olup olmadığını boolean olarak verir
# True
g3.hammiltion_path                  # Grafta euler path bulunuyorsa pathi array olarak döndürür. Bulunmuyorsa nil döndürür.
# [3,4,0,2,1,6,5]
```
