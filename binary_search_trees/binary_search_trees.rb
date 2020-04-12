class Node
  include Comparable
  attr_accessor :data, :left, :right
  def initialize(data=nil,left=nil,right=nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    return nil if other == nil
   self.data <=> other.data
  end

end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = clean(array)
    r = Node.new(array[(array.length - 1)/2])
    array.each do |num|
      next if num == r.data
      node = Node.new(num)
      if node < r
        insert_left(r,node)
      else
        insert_right(r,node)
      end
    end
    return r
  end

  def insert(data)
    node = Node.new(data)
    if node < root
      return  insert_left(root,node)
    else
      return insert_right(root,node)
    end
  end

  def delete(data)
    a = root
    node = Node.new(data)
    if node == root
      self.root = Node.new(root.left.data, root.left.left, root.right)
    elsif node < root
      return  delete_left(root,node)
    else
      return delete_right(root,node)
    end
  end

  def find(data)
    a = self.root
    node = Node.new(data)
    if node < root
      a = a.left until a == node || a == nil
    else
      a = a.right until a == node || a == nil
    end
    return a
  end

  def level_order
    return if self.root == nil
    q = []
    q.push(root);
   while !q.empty?
     current = q[0]
     yield(current)
     q.push(current.left) if current.left != nil
     q.push(current.right) if current.right != nil
     q.shift
   end
  end

  def level_order_recursion(root=self.root,q=[root],&block)
    return root if self.root == nil
    return nil if q[0] == nil
    current = q[0]
    yield(q[0]) if q[0] != nil
    q.push(current.left) if current.left != nil
    q.push(current.right) if current.right != nil
    q.shift
    return level_order_recursion(current,q,&block)
  end

  ["pre","in","post"].each do |method|
   define_method "#{method}order" do |root=self.root,&block|
      return root if root == nil
      case(method.to_s)
      when 'pre'
        block.call(root)
        preorder(root.left,&block)
        preorder(root.right,&block)
      when 'in'
        inorder(root.left,&block)
        block.call(root)
        inorder(root.right,&block)
      when 'post'
        postorder(root.left,&block)
        postorder(root.right,&block)
        block.call(root)
      end
    end
  end

  def depth(node)
    a = 0
    depth = 0
    node = find(node.data)
    found = false
    return nil if node == nil
    level_order do |x|
      found = true if x == node
      if found == true
        depth += 1 if a % 2 == 0
      end
      a += 1
    end
    depth
  end

  def balanced?
    left = 0
    right = 0
    inorder do |x|
      left += 1 if root < x
      right += 1 if root > x
    end
    return (left - right).abs <= 1
  end

  def rebalance!
    array = []
    level_order do |x|
      array.push(x.data)
    end
    self.root = build_tree(array)
  end

  private
  def clean (array)
    return array.sort.uniq.reverse
  end

  def insert_right(root,node)
    a = root
    while a.right != nil
      a = a.right
    end
      a.right = node
  end

  def insert_left(root,node)
    a = root
    while a.left != nil
      a = a.left
    end
    if node > a
      a.right = node
    else
      a.left = node
    end
  end


end
tree = Tree.new(Array.new(15) { rand(1..100) })
tree.balanced?
puts 'preoder'
tree.preorder do |x|
  print x.data
  print ", "
end
puts ''
puts "inorder"
tree.inorder do |x|
  print x.data
  print ", "
end
puts ''
puts "postorder"
tree.postorder do |x|
  print x.data
  print ", "
end
tree.insert(101)
tree.insert(105)
tree.insert(108)
tree.insert(190)
puts ''
puts "balanced?: #{tree.balanced?}"
tree.rebalance!
puts 'Rebalanced!'
puts "balanced?: #{tree.balanced?}"
puts 'preoder'
tree.preorder do |x|
  print x.data
  print ", "
end
puts ''
puts "inorder"
tree.inorder do |x|
  print x.data
  print ", "
end
puts ''
puts "postorder"
tree.postorder do |x|
  print x.data
  print ", "
end

tree_b = a = Tree.new([52, 46, 45, 31, 27, 9, 2, 1, 93, 92, 90, 82, 66, 57])
tree_b.insert(7)
puts ''
puts 'level order'
tree_b.level_order do |x|
  print x.data
  print ", "
end
puts ''
puts "preoder"
tree_b.preorder do |x|
  print x.data
  print ", "
end
tree_b.rebalance!
puts ''
puts 'rebalance order'
tree_b.level_order do |x|
  print x.data
  print ", "
end
