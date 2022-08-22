# this creates the game player objects
class Player
  attr_accessor :name, :symbol, :choices, :combinations, :wins

  def initialize
    @choices = []
    @combinations = []
    @wins = 0
  end
end

# this is the game
class Tictactoe
  def initialize(player1, player2)
    @winning_combinations = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[3 6 9], %w[2 5 8], %w[1 4 7], %w[3 5 7],
                             %w[1 5 9]]
    @moves = 9
    @player1 = player1
    @player2 = player2
    greeting
    @positions = %w[1 2 3 4 5 6 7 8 9]
    play_board
    symbol_set
    player_turn
    determine_winner
    winner_declaration
  end

  # private

  attr_accessor :positions, :moves, :player1, :player2, :winning_combinations

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
      puts "'#{@player1.symbol}' selected_number by player 1, choose another"
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
    selected_number = gets.chomp.to_i
    checker(selected_number)
    play_game(player, selected_number)
    @moves -= 1
  end

  def player2_play
    player = @player2
    puts 'player 2 choose a number on the board'
    selected_number = gets.chomp.to_i
    checker(selected_number)
    play_game(player, selected_number)
    @moves -= 1
  end

  def checker(selected_number)
    while selected_number.zero?
      puts 'select again'
      selected_number = gets.chomp.to_i
    end
  end

  def play_game(player, selected_number)
    p1 = selected_number.to_s
    if positions.include?(p1)
      positions[positions.index(p1)] = player.symbol
    else
      puts 'select another'
      p1 = gets.chomp
      positions[positions.index(p1)] = player.symbol
    end
    player.choices.push(p1)
    # play_board
  end

  def determine_winner
    players = [player1, player2]
    players.each do |player|
      player.choices.combination(3) { |combination| player.combinations.push(combination) }
      player.combinations.each do |combination|
        player.wins += 1 if @winning_combinations.include?(combination)
      end
    end
  end

  def winner_declaration
    puts "\t #{player1.name} score: #{player1.wins}"
    puts "\t #{player2.name} score: #{player2.wins}"
    puts player1.wins > player2.wins ? "\t#{player1.name} WINS!!!" : "\t#{player2.name} WINS!!!"
  end
end

player1 = Player.new
player2 = Player.new
game = Tictactoe.new(player1, player2)
