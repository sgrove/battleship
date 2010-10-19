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
  [HIGH] Check when board has no undamaged ship pieces left [DONE]

=end

def new_board
  return [
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
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
end

def still_alive(board)
  alive = false
  board.each do |row|
    alive = true if row.member? 1
  end

  return alive
end

def show_board(board)
  board.each { |row| puts row.inspect }
end

def place_value(board, x, y, value)
  board[y][x] = value
end

def place_ship(board, orientation, x, y, length)
  # TODO: Probably a nicer way to handle orientation,
  #       don't care for the conditional here.
  if "horizontal" == orientation
    length.times do |offset|
      place_value(board, x + offset, y, 1)
    end
  elsif "vertical" == orientation
    length.times do |offset|
      place_value(board, x, y + offset, 1)
    end
  end
end

def value_at(board, x, y)
  return board[y][x]
end

def bomb(board, x, y)
  if 1 == value_at(board, x, y)
    place_value(board, x, y, 2)
    return true
  end

  return false
end
