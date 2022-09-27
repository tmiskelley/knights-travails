# frozen_string_literal: true

# Models an individual sqaure on chess board
class Square
  attr_accessor :parent
  attr_reader :value, :children

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

# Models chess knight piece, utilizing BFS graph traversal for movement simulation
class Knight
  def initialize(start, finish)
    @start = start
    @finish = finish
    @board = GameBoard.new
  end

  def search(spot = @start, queue = [], visited = [])
    current_square = @board.find_square(spot)
    return path(current_square) if spot == @finish

    visited.push(spot)

    current_square.children.each do |coordinate|
      next if visited.include?(coordinate)

      child = @board.find_square(coordinate)

      child.parent = spot
      queue.push(child.value) unless queue.include?(child.value) || visited.include?(child.value)
    end
    search(queue.shift, queue, visited)
  end

  private

  def path(current_node, array = [])
    array.unshift(current_node.value)
    path(@board.find_square(current_node.parent), array) unless current_node.parent.nil?
    array
  end
end

def knight_moves(start, finish)
  return [start, finish] if start == finish

  path = Knight.new(start, finish).search
  puts "You made it in #{path.size - 1} moves! Heres your path:"
  path.each { |arr| p arr }
end
