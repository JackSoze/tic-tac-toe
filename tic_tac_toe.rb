# this creates the game player objects
class Player
  attr_accessor :name, :symbol
end

# this is the game
class Tictactoe
  @player1_choices = []

  def initialize(player1, player2)
    @moves = 9
    @player1 = player1
    @player2 = player2
    greeting
    @positions = %w[1 2 3 4 5 6 7 8 9]
    play_board
    symbol_set
    player_turn
  end

  private

  attr_accessor :positions, :moves

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
      puts "'#{@player1.symbol}' selected by player 1, choose another"
      @player2.symbol = gets.chomp
    end
  end

  def player_turn
    while moves.positive?
      player1_play
      break if moves.zero?

      player2_play
    end
  end

  def player1_play
    player = @player1
    puts 'player 1 choose a number on the board'
    selected = gets.chomp.to_i
    checker(selected)
    play_game(player, selected)
    @moves -= 1
  end

  def player2_play
    player = @player2
    puts 'player 2 choose a number on the board'
    selected = gets.chomp.to_i
    checker(selected)
    play_game(player, selected)
    @moves -= 1
  end

  def checker(selected)
    while selected.zero?
      puts 'select again'
      selected = gets.chomp.to_i
    end
  end

  def play_game(player, selected)
    p1 = selected.to_s
    if positions.include?(p1)
      positions[positions.index(p1)] = player.symbol
    else
      puts 'select another'
      p1 = gets.chomp
      positions[positions.index(p1)] = player.symbol
    end
    play_board
  end
end

player1 = Player.new
player2 = Player.new
game = Tictactoe.new(player1, player2)
puts game.greeting
