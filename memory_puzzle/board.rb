require_relative 'card.rb'

class Board

  attr_reader :board

  def initialize(board_size)
    raise "invalid board size" if board_size.odd?
    @board = populate(board_size)
  end

  def populate(board_size)

    board_init = Array.new(board_size) {Array.new(board_size)}
    array = []
    (1..(board_size**2)/2).each do |card|
      array << Card.new(card)
      array << Card.new(card)
    end
    idx = 0
    array = array.shuffle
    (0..board_size-1).each do |n|
      board_init[n] = array[idx, board_size]
      idx += board_size
    end
    board_init

  end

  def render
    @board.each do |line|
      line.each do |num|
        if num.show
          print "| #{num.value} |"
        elsif num.show == false
          print "|    |"
        end
      end
      print "\n"
    end
  end

  def won?
    @board.flatten.all? {|card| card.show == true}
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def reveal

  end

end

# if __FILE__ == $PROGRAM_NAME
#   board = Board.new(6)
#   board.render
#   board.board.length
# end
