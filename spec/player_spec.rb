require_relative '../lib/player'
require_relative '../lib/grid'
require_relative '../lib/game'
require_relative '../lib/turn'

RSpec.describe Player do
  let(:player) { described_class.new }

  describe '#new' do
    subject { described_class.new }

    it { is_expected.to have_attributes(token: be_a(String)) }
  end

  describe '#produce_turn' do
    let(:game_double) { instance_double(Game, grid: double(Grid, width: 20)) }

    subject { player.produce_turn(game_double) }

    it { is_expected.to be_a(Turn) }
    it { is_expected.to have_attributes(token: be_a(String), position: be_an(Integer)) }
  end
end
