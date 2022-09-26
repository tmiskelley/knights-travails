# frozen_string_literal: true

# Represents individual square on chess board
class Square
  attr_reader :position, :children

  MOVES = [
    [-2, -1], [-2, 1], [-1, -2], [-1, 2],
    [1, -2], [1, 2], [2, -1], [2, 1]
  ].freeze

  def initialize(data)
    @position = data
    @children = add_children
  end

  def add_children
    children = MOVES.map { |arr| [@position[0] + arr[0], @position[1] + arr[1]] }
    children.reject! { |arr| arr.reject! { |e| e > 7 || e.negative? } }
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
