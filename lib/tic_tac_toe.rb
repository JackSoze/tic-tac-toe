# this creates the game player objects
class Player
  attr_accessor :name, :symbol, :choices, :combinations, :wins

  def initialize
    @choices = []
    @combinations = []
    @wins = 0
    @name = nil
  end

  def update_wins
    @wins += 1
  end

  def create_combinations
    choices.combination(3) { |combination| combinations.push(combination) }
  end
end

# end game actions for two player games
module TwoPlayerGameBasics
  def greeting
    puts 'welcome to the game Tic-Tac-Toe'
    player_names
  end

  # called in greeting
  def player_names
    puts 'please enter player 1 name'
    @player1.name = gets.chomp
    # sleep 1.5
    puts 'please enter player 2 name'
    @player2.name = gets.chomp
  end
end

# this is the game
class Tictactoe
  include TwoPlayerGameBasics
  def initialize(player1, player2)
    @winning_combinations = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[3 6 9], %w[2 5 8], %w[1 4 7], %w[3 5 7],
                             %w[1 5 9]]
    @moves = 9
    @player1 = player1
    @player2 = player2
    @positions = %w[1 2 3 4 5 6 7 8 9]
  end

  attr_accessor :positions, :moves, :player1, :player2, :winning_combinations

  def full_game
    greeting
    symbol_set
    play_board
    player_turn
    create_player_combinations
    calculate_wins
    determine_winner
    declare_winner
    replay
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

  # called in player_turns
  def player1_play
    player = @player1
    puts "#{player1.name} choose a number on the board"
    selected_number = gets.chomp.to_i
    checker(selected_number)
    play_game(player, selected_number)
    @moves -= 1
  end

  # called in player_turns
  def player2_play
    player = @player2
    puts "#{player2.name} choose a number on the board"
    selected_number = gets.chomp.to_i
    checker(selected_number)
    play_game(player, selected_number)
    @moves -= 1
  end

  # supports player_play
  def checker(selected_number)
    while selected_number.zero?
      puts 'select again'
      selected_number = gets.chomp.to_i
    end
  end

  # supports player_play
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
    play_board
  end

  def create_player_combinations
    player1.create_combinations
    player2.create_combinations
  end

  def calculate_wins
    players = [player1, player2]
    players.each do |player|
      player.combinations.each do |player_combination|
        player.update_wins if winning_combinations.include?(player_combination)
      end
    end
  end

  def determine_winner
    if player1.wins > player2.wins 
      player1
    elsif player2.wins > player1.wins
     player2
    else
      nil
    end
  end

  def declare_winner
    sleep 1
    puts 'determing the winner'
    sleep 2
    winner = determine_winner
    case winner
    when nil
      puts "The game is a tie, scores below" 
      puts "#{player1.name}:#{player1.wins}"
      puts "#{player2.name}:#{player2.wins}"
    when player1
      puts "#{player1.name} won the game with #{player1.wins}"
      puts "#{player2.name} scored #{player2.wins}"
    when player2
      puts "#{player2.name} won the game with #{player2.wins}"
      puts "#{player1.name} scored #{player1.wins}"
    end
   puts 'thank you for playing!!'
  end

  def replay
    players_restart
    puts "\nwould you like to play again?"
    answer = gets.chomp
    game = Tictactoe.new(player1, player2) if answer == 'yes'
  end

  # to reset the players parameters
  def players_restart
    players = [player1, player2]
    players.each do |player|
      player.choices = []
      player.combinations = []
      player.wins = 0
    end
  end
end

player1 = Player.new
player2 = Player.new
game = Tictactoe.new(player1, player2)
game.full_game
