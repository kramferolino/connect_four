require_relative 'board'
require_relative 'player'
require_relative 'miscellaneous'

class Game
  include Miscellaneous

  def initialize
    @board = Board.new
    @player1 = Player.new(yellow_circle)
    @player2 = Player.new(blue_circle)
    @turn = 0
  end

  def play
    introduction
    set_player_name
    loop do
      curr_player = player_turn
      @board.display_board
      column = player_input(curr_player)
      @board.update_board(@board.available_row(column), column, curr_player.symbol)
      break if game_over?(curr_player) || draw?
    end
    @board.display_board
  end

  def player_input(player)
    loop do
      puts "#{player.symbol} #{player.name}'s turn."
      puts 'Enter column number: '
      column = gets.chomp.to_i - 1
      return column if verify_input(column)

      puts "Invalid input!\n\n"
    end
  end

  def verify_input(input)
    input.between?(0, 6) && !@board.full_column?(input)
  end

  def player_turn
    @turn += 1
    @turn.odd? ? @player1 : @player2
  end

  def game_over?(player)
    6.times do |row|
      7.times do |column|
        if @board.check_row(row, column, player.symbol)
          puts "\e[35m#{player.name}\e[0m won!"
          return true
        end
      end
    end
    false
  end

  def draw?
    if @turn == 42
      puts 'Draw!'
      true
    end
  end

  private

  def introduction
    puts <<~HEREDOC
      Welcome to Connect Four!

      This is a PvP game. Match the same colour in four consecutive cells to win!

      Goodluck!
      Type any to continue:
    HEREDOC
    gets.chomp
  end

  def ask_player_name(number)
    puts "Enter player#{number} name: "
    gets.chomp
  end

  def set_player_name
    @player1.name = ask_player_name(1)
    @player2.name = ask_player_name(2)
  end
end