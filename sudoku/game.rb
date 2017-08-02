require_relative 'board.rb'

class Game

  attr_reader :board

  def initialize(board)
    @board = Board.new(board)
  end

  def run
    puts "Welcome to sudoku!"
    until @board.solved?
      @board.render
      @board.make_move
    end
    puts "You won!"
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new("puzzles/sudoku2.txt")
  game.run
end
