require_relative "../lib/game"

def push_string(grid, lines)
  lines.each_line.map(&:chomp).reverse_each do |line|
    line.each_char.with_index do |character, col_index|
      grid.push(character, col_index)
    end
  end
end

RSpec.describe Game do
  let(:game) { described_class.new(width: 10, height: 10) }

  describe "#new" do
    it "initializes" do
      described_class.new(width: 10, height: 10)
    end

    it "initializes with optional winning line length" do
      described_class.new(width: 10, height: 10, scoring_line_length: 5)
    end
  end

  describe "#submit" do
    let(:turn) { Turn.new(token: "x", position: 2) }

    it "adds the token to the grid" do
      expect { game.submit(turn) }.to change { game.grid.to_a[2][0] }.from(nil).to("x")
    end

    it "raises if grid doesn't take any more turns" do
      expect { 100.times { game.submit(turn) } }.to raise_exception("column full")
    end
  end

  describe "#scoring_line_presences" do
    subject { game.scoring_line_presences }

    before do
      push_string(game.grid, grid_input)
    end

    context "when grid is empty" do
      let(:grid_input) { "" }

      it { is_expected.to be_empty }
    end

    context "when there's a row of less than 4" do
      let(:grid_input) do
        <<~STR
          xxx
        STR
      end

      it { is_expected.to have_attributes(count: 0) }
    end

    context "when there's a row of 4" do
      let(:grid_input) do
        <<~STR
          xxxx
        STR
      end

      it { is_expected.to have_attributes(count: 1) }
    end

    context "when there's a row of more than 4 it still counts as one" do
      let(:grid_input) do
        <<~STR
          xxxxxxxxx
        STR
      end

      it { is_expected.to have_attributes(count: 1) }
    end

    context "when there are two different rows of 4" do
      let(:grid_input) do
        <<~STR
          xxxx
          ----
        STR
      end

      it { is_expected.to have_attributes(count: 2) }
    end

    context "when there's a column of less than 4" do
      let(:grid_input) do
        <<~STR
          x
          x
          x
        STR
      end

      it { is_expected.to have_attributes(count: 0) }
    end

    context "when there's a column of 4" do
      let(:grid_input) do
        <<~STR
          x
          x
          x
          x
        STR
      end

      it { is_expected.to have_attributes(count: 1) }
    end

    context "when there's a column of more than 4 still counts as one" do
      let(:grid_input) do
        <<~STR
          x
          x
          x
          x
          x
        STR
      end

      it { is_expected.to have_attributes(count: 1) }
    end

    context "when there are two different columns of 4" do
      let(:grid_input) do
        <<~STR
          x-
          x-
          x-
          x-
        STR
      end

      it { is_expected.to have_attributes(count: 2) }
    end

    context "when there's a downward diagonal" do
      let(:grid_input) do
        <<~STR
          x000
          -x00
          --x0
          ---x
        STR
      end

      it { is_expected.to have_attributes(count: 1) }
    end

    context "when there's a upward diagonal" do
      let(:grid_input) do
        <<~STR
          ---x
          --x0
          -x00
          x000
        STR
      end

      it { is_expected.to have_attributes(count: 1) }
    end

    context "when there are two upward and downward diagonals crossing" do
      let(:grid_input) do
        <<~STR
          -x0x-
          0-x-0
          0x-x0
          x-0-x
        STR
      end

      it { is_expected.to have_attributes(count: 4) }
    end

    context "when there's everything of it" do
      let(:grid_input) do
        <<~STR
          xxxx-0
          00x-00
          00-x00
          ----x0
        STR
      end

      it { is_expected.to have_attributes(count: 5) }
    end
  end
end
