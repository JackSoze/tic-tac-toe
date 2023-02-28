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