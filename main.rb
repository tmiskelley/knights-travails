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

def knight_moves(start, finish)
  start_square = Square.new(start)
  return [start, finish] if start_square.children.any? { |arr| arr == finish }
end
