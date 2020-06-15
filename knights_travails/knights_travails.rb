class Node
  include Comparable
  attr_accessor :x, :y, :next, :previous
  def initialize(data)
    return nil if data[0] < 0 || data[1] < 0 || data[0] > 7 || data[1] > 7
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
      return nil if (data[0] < 0 || data[0] > 7) && (data[1] < 0 || data[1] > 7)
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
    return nil if data[0] < 0 || data[0] > 7 || data[1] < 0 || data[1] > 7
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
        # if x.next == nil && x.x != nil && x.y != nil
      #     next
        # end

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

  def build_moves()
    node = graph.starting_point
    8.times do
      graph.traverse do |node|
      #  break if node.x == 8 && node.y == 6
       if  node.next == nil && node.x != nil && node.y != nil
          build(node)
       end
    end
  end
  end

  def build(node)
    node = graph.find([node.x, node.y])
    return if node.next != nil
    up = build_up(node)
    down = build_down(node)
    left = build_left(node)
    right = build_right(node)
  end

  def build_up(node)
   if node == graph.starting_point
    graph.insert([node.x+1,node.y-2])
    graph.insert([node.x-1,node.y-2])
   else
    graph.insert_at([node.x+1,node.y-2], [node.x, node.y])
    graph.insert_at([node.x-1,node.y-2], [node.x, node.y])
   end
  end

  def build_left(node)
   if node == graph.starting_point
    graph.insert([node.x-2,node.y+1])
    graph.insert([node.x-2,node.y-1])
   else
     graph.insert_at([node.x-2,node.y+1], [node.x, node.y])
     graph.insert_at([node.x-2,node.y-1], [node.x, node.y])
   end
  end

  def build_right(node)
    if node == graph.starting_point
      graph.insert([node.x+2,node.y+1])
      graph.insert([node.x+2,node.y-1])
    else
      graph.insert_at([node.x+2,node.y+1], [node.x, node.y])
      graph.insert_at([node.x+2,node.y-1], [node.x, node.y])
    end
  end

  def build_down(node)
    if node == graph.starting_point
     graph.insert([node.x+1,node.y+2])
     graph.insert([node.x-1,node.y+2])
    else
     graph.insert_at([node.x+1,node.y+2], [node.x, node.y])
     graph.insert_at([node.x-1,node.y+2], [node.x, node.y])
    end

  #  if node = graph.starting_point
  #    graph.insert([node.x+1,node.y+2])
    #  graph.insert([node.x-1,node.y+2])
    #else
    #  graph.insert_at([node.x+1,node.y+2], [node.x, node.y])
    #  graph.insert_at([node.x-1,node.y+2], [node.x, node.y])
  #  end
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

game_board.knight.move(3,3)
game_board.knight.move(4,3)
game_board.knight.move(4,5)
game_board.knight.move(0,4)
game_board.show

gboard = GameBoard.new()
graph = gboard.graph
gboard.graph.starting_point = Node.new([0,0])
graph.insert([3,3])
three = graph.find([3,3])
gboard.build_up(three)
gboard.build_down(three)
#gboard.build(Node.new([3,3]))
graph.traverse do |node|
  puts node
end

#gboard.build_all_possible_moves(a,[3,3])
=begin
gboard.build_moves
#puts "next: #{a.next.next}"
three = graph.find([4,5])
#gboard.build(Node.new([4,5]))
graph.traverse do |node|
  if node.previous != nil && node.previous.x == 3 && node.previous.y == 3 # &&  node.next != nil && node.next.x == 4 && node.next.y == 5
    three = node
    puts node
  end

end
gboard.build(three.next.previous.next)
puts "graph: #{three.next.previous.next.next}"
=end
