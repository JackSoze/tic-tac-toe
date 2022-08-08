# this creates the game player objects
class Player
  attr_accessor :name, :symbol
end

# this is the game
class Tictactoe
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    greeting
    @positions = %w[1 2 3 4 5 6 7 8 9]
    # play_board
    symbol_set
  end

  private

  attr_accessor :positions

  def greeting
    puts 'welcome to the game Tic-Tac-Toe'
    # sleep 1.5
    player_names
  end

  def player_names
    puts 'please enter player 1 name'
    @player1.name = gets.chomp
    # sleep 1.5
    puts 'please enter player 2 name'
    @player2.name = gets.chomp
  end

  def play_board
    row1 =  "#{positions[0]}| #{positions[1]}| #{positions[2]}"
    row2 =  "#{positions[3]}| #{positions[4]}| #{positions[5]}"
    row3 =  "#{positions[6]}| #{positions[7]}| #{positions[8]}"
    divider = '.......'

    puts "#{row1} \n#{divider}\n#{row2} \n#{divider}\n#{row3}"
  end

  def symbol_set
    puts 'player 1 choose your symbol'
    @player1.symbol = gets.chomp
    puts "player 2, choose your symbol which should not be #{@player1.symbol}"
    @player2.symbol = gets.chomp
    while @player1.symbol == @player2.symbol
      puts 'put another value for your symbol'
      @player2.symbol = gets.chomp
    end
  end
end

player1 = Player.new
player2 = Player.new
game = Tictactoe.new(player1, player2)
puts player1.name
puts player1.symbol
