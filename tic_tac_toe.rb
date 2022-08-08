# this creates the game player objects
class Player
  attr_accessor :name
end

# this is the game
class Tictactoe
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    greeting
  end

  private

  def greeting
    puts 'welcome to the game Tic-Tac-Toe'
    sleep 1.5
    player_names
  end

  def player_names
    puts 'please enter player 1 name'
    @player1.name = gets.chomp
    sleep 1.5
    puts 'please enter player 2 name'
    @player2.name = gets.chomp
  end

  def play_board; end
end

player1 = Player.new
player2 = Player.new
game = Tictactoe.new(player1, player2)
puts player1.name
