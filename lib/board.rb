require_relative 'miscellaneous'

class Board
  include Miscellaneous

  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) { empty_circle } }
  end

  def display_board
    @grid.each do |row|
      puts row.join(' ')
    end
    puts (1..7).to_a.join(' ')
  end

  def update_board(row, column, symbol)
    @grid[row][column] = symbol
  end

  def full_column?(input)
    @grid[0][input] != empty_circle
  end

  def available_row(column)
    row = 0
    loop do
      return row if row == 5 || @grid[row + 1][column] != empty_circle

      row += 1
    end
  end

  def check_vertical(row, column, symbol)
    return if row > 2

    @grid[row][column] == symbol && @grid[row + 1][column] == symbol && @grid[row + 2][column] == symbol && @grid[row + 3][column] == symbol
  end

  def check_horizontal(row, column, symbol)
    return if column > 3

    @grid[row][column] == symbol && @grid[row][column + 1] == symbol && @grid[row][column + 2] == symbol && @grid[row][column + 3] == symbol
  end

  def check_diagonals(row, column, symbol)
    return unless row < 3

    check_right_diagonal(row, column, symbol) || check_left_diagonal(row, column, symbol)
  end

  def check_row(row, column, symbol)
    check_horizontal(row, column, symbol) || check_vertical(row, column, symbol) || check_diagonals(row, column, symbol)
  end

  def check_left_diagonal(row, column, symbol)
    return if column > 3

    @grid[row][column] == symbol && @grid[row + 1][column + 1] == symbol && @grid[row + 2][column + 2] == symbol && @grid[row + 3][column + 3] == symbol
  end

  def check_right_diagonal(row, column, symbol)
    return if column < 3

    @grid[row][column] == symbol && @grid[row + 1][column - 1] == symbol && @grid[row + 2][column - 2] == symbol && @grid[row + 3][column - 3] == symbol
  end
end