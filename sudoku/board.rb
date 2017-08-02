require_relative 'tile.rb'

class Board

  attr_reader :grid

  def initialize(board)
    @grid = File.readlines("#{board}").map(&:chomp)
    @grid = self.populate
  end

  def populate
    result = []
    @grid.each do |str|
      result << str.chars.map(&:to_i)
    end

    result.each do |outside|
      outside.map! do |inside|
        if inside == 0
          inside = Tile.new(" ")
        else
          inside = Tile.new(inside, true)
        end
      end
    end
    result
  end

  def render
      counter = 1
      puts "------------------------------"
      @grid.each_with_index do |outside, idx|
        i = 1
        outside.each do |inside|
          if i == 3
            print "|#{inside.value}|+"
            i = 1
          else
            print "|#{inside.value}|"
            i += 1
          end
        end

        if counter == 3
          puts "\n"
          puts "------------------------------"
          counter = 1
        else
          puts "\n"
          counter += 1
        end
      end
  end


  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos,mark)
    x, y = pos
    @grid[x][y].value = mark
  end

  def solved? 
    @grid.each do |outside|
      return outside.all? {|el| el.is_a?(Integer)}
    end
  end

  def make_move
    puts "Which row?"
    row = gets.chomp.to_i-1
    puts "Which column?"
    column = gets.chomp.to_i-1
    puts "What number?"
    number = gets.chomp.to_i

    if valid_input?([row,column,number])
      @grid[row,column] = number
      return
    else
      puts "invalid input"
      make_move
    end

  end


  def valid_input?(elements)
    row, column, number = elements
    return false if @grid[row].include?(number)
    @grid.any? do |array|
      if array[column] == number
        return false
      end
    end
    return true

  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new("puzzles/sudoku2.txt")
  board.render
end
