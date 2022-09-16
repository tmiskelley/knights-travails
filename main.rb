# frozen_string_literal: true

# Represents individual square on chess board
class Square
  attr_reader :position, :children

  MOVES = [
    [1, 2], [-2, -1], [-1, 2], [2, -1],
    [1, -2], [-2, 1], [-1, -2], [2, 1]
  ].freeze

  def initialize(data)
    @position = data
    @children = add_children(@position)
  end

  def add_children(coordinate)
    children = MOVES.map { |arr| [coordinate[0] + arr[0], coordinate[1] + arr[1]] }
    children.reject! { |arr| arr.reject!(&:negative?) }
    children
  end
end

# Represents an 8x8 chess game board, comprised of 64 square nodes
class GameBoard
  attr_reader :squares

  def initialize
    @squares = []
    create_squares
  end

  def create_squares
    coordinates = [*0..7].repeated_permutation(2).to_a
    coordinates.each { |arr| @squares.push(Square.new(arr)) }
  end

  def find(coordinate)
    @squares.each do |square|
      return square if square.position == coordinate
    end
    raise "Square #{coordinate} could not be found."
  end

  def print_board
    squares.each { |square| p square }
  end
end

# Represents chess knight, generating and storing it's moves
class Knight
  def initialize(start, finish)
    @board = GameBoard.new
    @start = @board.find(start)
    @finish = finish
  end

  def move_knight(current_square = @start, queue = [], array = [])
    array.push(current_square.position)
    current_square.children.each { |arr| queue.push(arr) }
    if current_square.children.any? { |arr| arr == @finish }
      array.push(@finish)
      return
    end
    move_knight(@board.find(queue.shift), queue, array)
    array
  end
end

def knight_moves(start, finish)
  return [start, finish] if Square.new(start).children.any? { |arr| arr == finish }

  Knight.new(start, finish).move_knight
end

knight_moves([3, 3], [7, 7])
