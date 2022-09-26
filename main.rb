# frozen_string_literal: true

# Models an individual sqaure on chess board
class Square
  attr_reader :value, :parent, :children

  MOVES = [
    [-2, -1], [-2, 1], [-1, -2], [-1, 2],
    [1, -2], [1, 2], [2, -1], [2, 1]
  ].freeze

  def initialize(value)
    @value = value
    @parent = nil
    @children = create_children
  end

  private

  def create_children
    children = MOVES.map { |arr| [@value[0] + arr[0], @value[1] + arr[1]] }
    children.reject! { |arr| arr.reject! { |e| e > 7 || e.negative? } }
    children
  end
end

# Models a chess game board, comprised of 64 square nodes
class GameBoard
  attr_reader :squares

  def initialize
    @squares = create_squares
  end

  def find_square(value)
    @squares.each { |square| return square if square.value == value }
    raise "Square #{value} does not exist."
  end

  def print_board
    @squares.each { |square| p square }
  end

  private

  def create_squares
    coordinates = []
    [*0..7]
      .repeated_permutation(2)
      .to_a
      .each { |arr| coordinates.push(Square.new(arr)) }
    coordinates
  end
end
