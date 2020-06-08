class Node
  include Comparable
  attr_accessor :x, :y, :next, :previous
  def initialize(data)
    return if data[0] < 0 || data[1] < 0 || data[0] > 8 || data[1] > 8
   @x = data[0]
   @y = data[1]
   @previous = nil
   @next = nil
  end

  def to_s
      return "x: #{x} y: #{y}"
  end

  def ==(other)
    return false if other == nil
    return nil if self == nil
    if x == other.x && y == other.y
      return true
    else
      return false
    end
  end
end

class Graph
  attr_accessor :starting_point
  def initialize(starting_point=[0,0])
    @starting_point = Node.new(starting_point)
  end

  def insert(data)
      return nil if (data[0] < 0 || data[0] > 8) && (data[1] < 0 || data[1] > 8)
      root = starting_point
      if root.next == nil
        append(root,data)
      else
        while root.next != nil
          root = root.next.previous
        end
        append(root,data)
      end
  end

  def insert_at(data,node)
    return nil if (data[0] < 0 || data[0] > 8) && (data[1] < 0 || data[1] > 8)
    node_found = find(node)
    return if node_found == nil
    if node_found.next == nil
      append(node_found,data)
      return
    else
      while node_found.next != nil
        node_found = node_found.next.previous
      end
      append(node_found,data)
    end
  end

  def find(data)
    node = Node.new(data)
    traverse do |x|
      return x   if x == node
    end
    nil
  end

  def contains(data)
    root = starting_point
    node = Node.new(data)
    while root != nil
      if root.next == nil && root.previous == nil
        root = root.previous
      end
      return if root == node
      root = root.next
    end
    root
  end

  def traverse(node=starting_point, &block)
    return node if node == nil
    yield(node)
    return node if node.next == nil && node.previous == nil
    traverse(node.next, &block) if node.next != nil
    traverse(node.previous, &block) if node.previous != nil && node.previous.next != nil
  end

  private
  def append(node,data)
      node.next = Node.new(data)
      node.next.previous = Node.new([node.x,node.y])
      node = node.next.previous
      node.previous = Node.new(data)
  end
end


class GameBoard
  attr_accessor :board
  attr_reader :knight, :graph

  def initialize
    @board = create_board
    @knight = Knight.new(self)
    @graph = Graph.new
  end

  def show
    puts ''
    8.times do |x|
      board[x].each do |b|
        print b.to_s
      end
      puts ''
    end
    nil
  end

  def knight_moves(starting_point, ending_point)
    graph = Graph.new(starting_point)

  end

  def build_all_possible_moves(starting_point=graph.starting_point,ending_point)

    starting_point =     build_moves(starting_point)
    a = 0
    starting_point = build_moves(starting_point.next)

  end

  def build_moves(node)
    root_node = node
    up = build_up(node)
    down = build_down(node)
    left = build_left(node)
    right = build_right(node)
    return node
  end

  def build_up(node)
   return nil if node.y - 2 < 0 && (node.x + 1 > 8 || node.x - 1 < 0)
   puts "node: #{node}"
   puts node == graph.starting_point
   if node == graph.starting_point
    graph.insert([node.x+1,node.y-2])
    graph.insert([node.x-1,node.y-2])
   else
    graph.insert_at([node.x+1,node.y-2], [node.x, node.y])
    graph.insert_at([node.x-1,node.y-2], [node.x, node.y])
   end
  end

  def build_left(node)
   return nil if node.x - 2 < 0 && (node.y + 1 > 8 || node.y - 1 < 0)
   if node == graph.starting_point
    graph.insert([node.x-2,node.y+1])
    graph.insert([node.x-2,node.y-1])
   else
     graph.insert_at([node.x-2,node.y+1], [node.x, node.y])
     graph.insert_at([node.x-2,node.y-1], [node.x, node.y])
   end
  end

  def build_right(node)
    return nil if node.x + 2 > 8 && (node.y + 1 > 8 || node.y - 1 < 0)
    if node == graph.starting_point
      graph.insert([node.x+2,node.y+1])
      graph.insert([node.x+2,node.y-1])
    else
      graph.insert_at([node.x+2,node.y+1], [node.x, node.y])
      graph.insert_at([node.x+2,node.y-1], [node.x, node.y])
    end
  end

  def build_down(node)
    return nil if node.y + 2 > 8 && (node.x + 1 > 8 || node.x - 1 < 0)
    if node = graph.starting_point
      graph.insert([node.x+1,node.y+2])
      graph.insert([node.x-1,node.y+2])
    else
      graph.insert_at([node.x+1,node.y+2], [node.x, node.y])
      graph.insert_at([node.x-1,node.y+2], [node.x, node.y])
    end
  end

  private
  def create_board
    array = []
    8.times do
      array.push(Array.new(8,'[ ]'))
    end
    array
  end

end


class Knight
  attr_accessor :x, :y, :horizontal, :vertical
  attr_reader :game_board
  def initialize(game_board)
   @x = nil
   @y = nil
   @game_board = game_board
  end

  def move(x,y)
    self.x = x
    self.y = y
    game_board.board[y][x] = '[K]'
  end
end
game_board = GameBoard.new

game_board.knight.move(2,3)
game_board.knight.move(3,3)
game_board.knight.move(4,4)
game_board.knight.move(0,4)
game_board.show
=begin

x = 2
y = 3

game_board.show
node1 = Node.new([5,3])
node2 = Node.new([2,3])
node3 = Node.new([1,6])
node4 = Node.new([1,8])
node5 = Node.new([7,2])
node6 = Node.new([9,4])
graph = Graph.new([1,1])
graph.insert_at([2,3],graph.starting_point)
graph.insert_at([5,4],graph.starting_point)
graph.insert_at([5,7],Node.new([5,4]))
graph.insert_at([2,7],Node.new([2,3]))
graph.insert_at([7,7],Node.new([7,6]))
a = graph.starting_point
length = 0
greatest = length
graph.traverse(a) do |x|
  puts x
end
puts graph.contains([5,4])
=end


gboard = GameBoard.new()
graph = gboard.graph
gboard.graph.starting_point = Node.new([1,2])
puts gboard.graph.starting_point
#gboard.build_all_possible_moves(a,[3,3])
gboard.build_moves(graph.starting_point)
graph.traverse do |x|
 puts x
end
#puts "next: #{a.next.next}"
puts "founded; #{graph.find([3,3])}"
