# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

#require_relative './hw6provided'

#add me on github.com/keent :)

class MyTetris < Tetris
  # your enhancements here
  
  attr_accessor :cheatBool
  # creates the window and starts the game

  def initialize
    super
    @cheatBool = []
  end

  # creates a canvas and the board that interacts with it  
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {self.cheat})
  end
  
  def cheat
    if @board.score < 100
      return
    end
    
    @board.score -= 100
    update_score
  
    @cheatBool.push(true)
  end
  
end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # your enhancements here

  # class method to choose the next piece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
  
  def self.next_cheat_piece(board)
    MyPiece.new(Cheat_Piece.sample, board)
  end
  
  # class array holding all the pieces and their rotations
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1], [-1, -1]]), #new like S
               [[[0, 0], [-2, 0], [-1, 0], [1, 0], [2, 0]], # new like longer (only needs two)
               [[0, 0], [0, -2], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [1, 0], [0, 1]])] #new like square 

  Cheat_Piece = [[[[0,0]]]]


end

class MyBoard < Board
  # your enhancements here
  attr_accessor :score
  
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
  end
  
  def rotate_180
    rotate_clockwise
    rotate_clockwise
  end
  
  # gets the next piece
  def next_piece
    if (@game.cheatBool.pop)
      @current_block = MyPiece.next_cheat_piece(self)
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end
  
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..4).each{|index| 
      current = locations[index];
      next if current == nil
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
  
end
