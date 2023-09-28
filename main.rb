require_relative './lib/game'

def main
  loop do
    game = Game.new
    game.play
    break unless another_game?
  end
end

def another_game?
  loop do
    puts 'Do you want to play again?'
    puts "\e[32m[1]\e[0m Play another round."
    puts "\e[31m[2]\e[0m Exit."
    input = gets.chomp
    return true if input == '1'
    return false if input == '2'
  end
end

main