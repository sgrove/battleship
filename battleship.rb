=begin
  Board in row-major format
  0 indexed

  Legend:
  0 - Sea
  1 - Ship
  2 - Damaged ship

  bomb(x, y) | ex: -> bomb(4, 1)
  ------------------------------
  [
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, B, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0]
  ]

  TODO:
  ===============================
  [HIGH] Keep ships from overlapping
  [LOW] Notify when single ship has been sunk
  [LOW] Keep track of how many undamaged pieces on a board
  [HIGH] Check when board has no undamaged ship pieces left [DONE]
  [HIGH] Prevent ships from being placed off the map

=end

class Board
  attr_reader :board, :width, :height

  def initialize(options = {})
    @width  = options[:width]  || 10     # Default to 10x10
    @height = options[:height] || 10     # Default to 10x10
    @board  = generate_board(@width, @height) # Parameterized because I hate state
  end

  def generate_board(width, height)
    blank_board = []

    height.times do
      row = []
      width.times do
        row << 0
      end
      blank_board << row
    end

    return blank_board
  end

  def alive?
    live_count != 0
  end

  def live_count
    count = 0 

    @board.each do |row|
      row.each do |column|
        count += 1 if 1 == column
      end
    end

    return count
  end

  def show
    puts "------------------------------"
    @board.each { |row| puts row.inspect }
    puts
  end

  def place_value(x, y, value)
    @board[y][x] = value
  end

  def place_ship(orientation, x, y, length)
    # TODO: Probably a nicer way to handle orientation,
    #       don't care for the conditional here.
    if "horizontal" == orientation
      length.times do |offset|
        place_value(x + offset, y, 1)
      end
    elsif "vertical" == orientation
      length.times do |offset|
        place_value(x, y + offset, 1)
      end
    end
  end

  def value_at(x, y)
    return @board[y][x]
  end

  def bomb(x, y)
    if 1 == value_at(x, y)
      place_value(x, y, 2)
      return true
    end

    return false
  end
end

board = Board.new
board.show
