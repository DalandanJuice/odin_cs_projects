class Node
  include Comparable
  attr_accessor :x, :y, :first_move, :second_move
  def initialize(data)
    if data[0] < 0 || data[1] < 0 || data[0] > 7 || data[1] > 7
      return 
    end
   @x = data[0]
    @y = data[1]
    @first_move = nil
    @second_move = nil
  end

  def to_s
    "x: #{x} y: #{y}"
  end

  def ==(other)
    if x == other.x && y == other.y
      return true
    else
      return false
    end
  end
end


class GameBoard
  attr_accessor :board
  attr_reader :knight
  def initialize
    @board = create_board
    @knight = Knight.new(self)
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

  def build_possible_moves(starting_square,ending_square)
    starting_node = Node.new(starting_square)
    ending_node = Node.new(ending_square)
    f = starting_node
    s = starting_node
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

  def move_first(starting_node,ending_node)
    f = starting_node
    while f != ending_node
      return nil if f == nil
      if f.x + 2 <= ending_node.x
        f.first_move = Node.new([f.x+2, f.y+1]) if f.y < ending_node.y
        f.first_move = Node.new([f.x+2, f.y-11]) if f.y > ending_node.y
      elsif f.y + 2 <= ending_node.y
        f.first_move = Node.new([f.x+1, f.y+2]) if f.x < ending_node.x
        f.first_move = Node.new([f.x+1, f.y-21]) if f.x > ending_node.x
      end
      f = f.first_move
    end
  end

  def move_horizontal(starting_node,ending_node)
    self.horizontal = Node.new(starting_node)
    node = horizontal
    ending_node = Node.new(ending_node)
    while node != ending_node
      if node.x + 2 <= ending_node.x 
        node.first_move = Node.new([node.x+2, node.y+1]) if node.y < ending_node.y
        node.first_move = Node.new([node.x+2, node.y-1]) if node.y > ending_node.y
        node = node.first_move
      elsif node.x - 2 >= ending_node.x
        node.first_move = Node.new([node.x-2, node.y+1]) if node.y < ending_node.y
        node.first_move = Node.new([node.x-2, node.y-1]) if node.y > ending_node.y
        node = node.first_move
      elsif node.y + 2 <= ending_node.y
        node.first_move = Node.new([node.x+1, node.y+2]) if node.x < ending_node.x
        node.first_move = Node.new([node.x-1, node.y+2]) if node.x > ending_node.x
        node = node.first_move
      elsif node.y - 2 >= ending_node.y
        node.first_move = Node.new([node.x+1, node.y-2]) if node.x < ending_node.x
        node.first_move = Node.new([node.x-1, node.y-2]) if node.x > ending_node.x
        node = node.first_move
      end
      puts node
    end
    horizontal
  end

  def move_vertical

  end
  def move_second
  end
end
game_board = GameBoard.new
game_board.show
game_board.knight.move(0,0)
game_board.knight.move(1,2)
game_board.knight.move(3,3)

game_board.show
knight = Knight.new(GameBoard.new)
puts knight.move_horizontal([0,0],[3,3])
puts ''
puts "#{a.first_move} first move"
#puts knight.move_horizontal([3,3],[2,3])
puts ''
#puts knight.move_horizontal([3,3],[2,3])
