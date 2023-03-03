require './lib/tic_tac_toe.rb'
describe Tictactoe do
  describe '#create_player_combinations' do
    let(:player1) {instance_double(Player)}
    let(:player2) {instance_double(Player)}
    subject(:game) {described_class.new(player1, player2)}
    before do
      allow(player1).to receive(:create_combinations)
      allow(player2).to receive(:create_combinations)
    end
    it 'sends a message to player to create combinations' do
      expect(player1).to receive(:create_combinations)
      expect(player2).to receive(:create_combinations)
      game.create_player_combinations
    end
  end

  describe '#calculate_wins' do
    let(:player1) {instance_double(Player, combinations: [['1','2','3']])}
    let(:player2) {instance_double(Player, combinations: [['1','2','3']])}
    subject(:game) {described_class.new(player1, player2)}
    it 'sends update_wins to player' do
      expect(player1).to receive(:update_wins)
      expect(player2).to receive(:update_wins)
      game.calculate_wins
    end
  end

  describe '#determine_winner' do
    let(:player1) {instance_double(Player, wins:3)}
    let(:player2) {instance_double(Player,'person')}
    subject(:game){described_class.new(player1, player2)}

    it 'returns player1 as winner if he has more wins' do
      allow(player2).to receive(:wins).and_return(0)
      result = game.determine_winner
      expect(result).to eq(player1)
    end

    it 'returns player2 as winner if he has more wins' do
      allow(player2).to receive(:wins).and_return(5)
      result = game.determine_winner
      expect(result).to eq(player2)
    end

    it 'returns nil if there are no winners/tie' do
      allow(player2).to receive(:wins).and_return(3)
      result = game.determine_winner
      expect(result).to eq(nil)
    end
  end

  describe '#player_turn' do
    let(:player1) {double('player1')}
    let(:player2) {double('player2')}
    subject(:game) { described_class.new(player1, player2)}
    context 'when the moves are negative' do
      it "it stops and doesn't receive player1_play" do
        game.moves = -1
        expect(game).not_to receive(:player1_play)
        game.player_turn
      end
    end
    context 'when the moves are 1' do
      it "receives player1_play but not player2_play" do
        
        allow(game).to receive(:moves).and_return(1,0)
        expect(game).to receive(:player1_play)
        expect(game).not_to receive(:player2_play)
        game.player_turn
      end
    end
  end

  #player2_play similar to player_1 play so test only one
  describe '#player2_play' do
    let(:player1) {double('player1')}
    let(:player2) {double('player2',name:'player2')}
    subject(:game) {described_class.new(player1, player2)}
    before do
      selected_number = '2'
      allow(game).to receive(:gets).and_return(selected_number)
      allow(game).to receive(:puts)
    end
    it 'send game the play_game message' do
      selected_number = '2'
      expect(game).to receive(:play_game).with(player2, selected_number.to_i)
      game.player2_play
    end
    it 'decrements the move by 1 each time' do
      selected_number = '2'
      game.moves = 2
      allow(game).to receive(:play_game).with(player2, selected_number.to_i)
      game.player2_play
      expect(game.moves).to eq(1)
    end
  end

  describe '#replay' do 
    let(:player1) {double('Player1')}
    let(:player2) {double('Player2')}
    subject(:game) {described_class.new(player1, player2)}
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:puts)
    end
    it 'sends the message players_restart to game' do
      allow(game).to receive(:gets).and_return('no')
      expect(game).to receive(:players_restart)
      game.replay
    end

    it 'initiates a new game when the answer is yes' do
      allow(game).to receive(:players_restart)
      allow(game).to receive(:gets).and_return('yes')
      expect(Tictactoe).to receive(:new).with(player1, player2)
      game.replay
    end

    it 'doesnt initiate a new game when answer is no' do  
      allow(game).to receive(:players_restart)
      allow(game).to receive(:gets).and_return('no')
      expect(Tictactoe).not_to receive(:new).with(player1, player2)
      game.replay
    end
  end

  describe '#play_game' do
    let(:player1) {instance_double(Player, symbol: 'x', choices:%W[2 3])}
    let(:player2) {instance_double(Player, symbol: 'o')}
    subject(:game) {described_class.new(player1,player2)}
    context 'when positions includes the selected number' do
      before do
        allow(game).to receive(:play_board)
      end
      it 'the game board position changes to player symbol' do
        selected_number = 1
        game.play_game(player1, selected_number)
        expect(game.positions[0]).to eq('x')
      end
  
      it "expect player.choices to include the chosen number " do
        selected_number = 1
        game.play_game(player1, selected_number)
        expect(player1.choices).to include(selected_number.to_s)
      end

      it 'expect game to receive play_board' do
        selected_number = 1
        expect(game).to receive(:play_game)
        game.play_game(player1, selected_number)
      end
    end

    context 'when positions doesnt include selected number' do
      before do
        allow(game).to receive(:play_board)
      end
      it 'asks for another number and updates' do
        selected_number1 = 1
        selected_number2 = '4'
        allow(game).to receive(:positions).and_return(%w[2 3 4])
        allow(game).to receive(:gets).and_return(selected_number2)
        game.play_game(player1, selected_number1)
        expect(game.positions[2]).to eq('x')
      end
    end
  end

end

describe Player do
  describe '#update_wins' do
    subject(:player) {Player.new}
    it 'updates wins' do
      expect {player.update_wins}.to change {player.wins}.by(1)
    end
  end

  describe '#create_combinations' do
    subject(:player) {described_class.new}
    context 'creates combinations from %W[1 2 3 4 5]' do
      before do
        allow(player).to receive(:choices).and_return(%w[1 2 3 4 5])
      end
      it 'includes several examples' do
        player.create_combinations
        expect(player.combinations).to include(["1", "2", "3"])
        expect(player.combinations).to include(["1", "3", "4"])
        expect(player.combinations).to include(["2", "4", "5"])
      end
      it 'has a length of 10' do
        player.create_combinations
        expect(player.combinations.length).to eq(10)
      end
    end
  end

  
end