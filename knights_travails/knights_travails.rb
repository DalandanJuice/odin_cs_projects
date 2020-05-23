class Node
  include Comparable
  attr_accessor :x, :y, :next, :previous
  def initialize(data)
    return if data[0] < 0 || data[1] < 0 || data[0] > 7 || data[1] > 7
   @x = data[0]
   @y = data[1]
   @previous = nil
   @next = nil
  end

  def to_s
    "x: #{x} y: #{y}"
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
      #return nil if (node.x < 0 || node.x > 8) && (node.y < 0 || node.y > 8)
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
    return nil if (node.x < 0 || node.x > 8) && (node.y < 0 || node.y > 8)
    root = starting_point
    root = root.next.previous if node == starting_point && root.next != nil
    while root != node
      if root.next == nil &&  root.previous.next != nil

        root = root.previous

      elsif root.next == nil && root.previous.next == nil
        return nil
      else
        root = root.next
      end
    end

    puts data.to_s
    append(root,data)
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

  def traverse(node, &block)
    return node if node == nil
    yield(node)
    traverse(node.next, &block)
    traverse(node.previous, &block) if node.previous != nil && node.previous == starting_point
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

  def build_moves(node,ending_point)
    end_point = Node.new(ending_point)
    up = build_up(node)
    down = build_down(node)
   left = build_left(node)
    right = build_right(node)
    return node
  end

  def build_up(node)
   return nil if node.y - 2 < 0
    graph.insert_at([node.x+1,node.y-2], node)
    graph.insert_at([node.x-1,node.y-2],node)
  end

  def build_left(node)
   return nil if node.x - 2 < 0
    graph.insert_at([node.x-2,node.y+1], node)
    graph.insert_at([node.x-2,node.y-1], node)
  end

  def build_right(node)
    return nil if node.x + 2 > 8
    graph.insert_at([node.x+2,node.y+1], node)
    graph.insert_at([node.x+2,node.y-1], node)
  end

  def build_down(node)
   return nil if node.y + 2 > 8
    graph.insert_at([node.x+1,node.y+2], node)
    graph.insert_at([node.x-1,node.y+2], node)
  end

  def build_possible_moves(starting_square,ending_square)
    starting_node = Node.new(starting_square)
    ending_node = Node.new(ending_square)
    f = starting_node
    s = starting_nodne
    puts "ffffffffffff #{f.x}"
    while f != ending_node || s != ending_node
      if f.x + 2 <= ending_node.x
        f.first_move = Node.new([f.x+2, f.y+1]) if f.y < ending_node.y
        f.first_move = Node.new([f.x+2, f.y-11]) if f.y > ending_node.y
          puts "first move x: #{f.first_move.x} y: #{f.first_move.y} "
          f = f.first_move
      elsif f.y + 2 <= ending_node.y
        f.first_move = Node.new([f.x+1, f.y+2]) if f.x < ending_node.x
        f.first_move = Node.new([f.x+1, f.y-21]) if f.x > ending_node.x
        puts "first move x: #{f.x} y: #{f.y} "
        f = f.first_move
      end
      if s.y + 2 <= ending_node.y
        s.second_move = Node.new([s.x+1,s.y+2]) if s.x < ending_node.x
        s.second_move = Node.new([s.x+1,s.y-2]) if s.x > ending_node.x
        puts "second move x: #{s.x} y: #{s.y} "
        s = s.second_move
      elsif s.x + 2 <= ending_node.x
        s.second_move = Node.new([s.x+2, s.y+1]) if s.y < ending_node.y
        s.second_move = Node.new([s.x+2, s.y-1]) if s.y > ending_node.y
        s = s.second_move
      end
    end
    puts f
    puts s
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

  def move(starting_position,ending_position)
  end

  def move(x,y)
    self.x = x
    self.y = y
    game_board.board[y][x] = '[K]'
  end
end
=begin
game_board = GameBoard.new
game_board.show
x = 2
y = 3
game_board.knight.move(2,3)
game_board.knight.move(3,3)
game_board.knight.move(4,4)
game_board.knight.move(0,4)
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
g = Graph.new([2,3])
graph = gboard.graph
g.insert([1,2])
g.insert([3,3])
g.insert([7,7])
g.insert([1,1])

g.traverse(g.starting_point) do |x|
  puts x
end
