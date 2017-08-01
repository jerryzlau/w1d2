require_relative 'card.rb'
require_relative 'board.rb'

class Game

  def initialize(board_size=4)
    @board = Board.new(board_size)
    @guessed_pos = []
  end

  def make_guess
    puts "Pick a card: enter a two-number array with values between 1 and 4"
    input1 = gets.chomp.to_i
    input2 = gets.chomp.to_i
    pos = [input1,input2]
    @board[pos].reveal
    pos
  end



  def run

    puts "Welcome to guess 2 cards."
    until @board.won?
      @board.render
      c1 = @board[make_guess]
      @board.render
      c2 = @board[make_guess]
      @board.render
      puts "\n"
      if !c1.equal(c2)
        c1.hide
        c2.hide
      end
    end

    puts "You have won!"
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.run
end
