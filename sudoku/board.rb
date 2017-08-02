require_relative 'tile.rb'

class Board

  attr_reader :grid

  def initialize(board)
    @grid = File.readlines(board).map(&:chomp)
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
          Tile.new(" ")
        else
          Tile.new(inside, true)
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


  def solved?
    @grid.flatten.map {|el| el.value}.all? {|el| el.is_a?(Integer)}
  end

  def make_move

    puts "Which row?"
    row = gets.chomp.to_i-1
    puts "Which column?"
    column = gets.chomp.to_i-1
    puts "What number?"
    number = gets.chomp.to_i
    
    if @grid[row][column].given
      puts "spot already has a number"
      return
    end

    if valid_input?([row,column,number])
      if !@grid[row][column].given
        @grid[row][column].value = number
        @grid[row][column].given = true
      else
        puts "That is a given tile. Try another spot."
      end

    else
      puts "invalid input"
      make_move
    end

  end

  def valid_input?(elements)
    row, column, number = elements
    #checks input value
    return false if !number.between?(0,8)

    #checks row
    temp = @grid.dup
    temp[row][column].value = number
    row_flag = temp[row].map {|el| el.value}.count(number) == 1

    #check column
    temp_col = []
    temp.each do |row|
      temp_col << row[column]
    end
    col_flag = temp_col.map {|el| el.value}.count(number) == 1

    row_flag && col_flag


  end


end

if __FILE__ == $PROGRAM_NAME
  board = Board.new("puzzles/sudoku2.txt")
  board.run
end
