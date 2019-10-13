require_relative '../lib/grid'

RSpec.describe Grid do
  let(:grid) { described_class.new(10, 10) }

  describe '#new' do
    it 'can initialize' do
      described_class.new(10, 10)
    end
  end

  describe '#push' do
    it 'adds tokens to the bottom of the grid' do
      grid.push('x', 0)
      grid.push('o', 1)
      grid.push('-', 5)
      expect(grid.to_a[0][0]).to eq('x')
      expect(grid.to_a[1][0]).to eq('o')
      expect(grid.to_a[5][0]).to eq('-')
    end

    it 'adds tokens on top of other tokens' do
      grid.push('o', 0)
      grid.push('x', 0)
      grid.push('-', 0)
      expect(grid.to_a[0][0]).to eq('o')
      expect(grid.to_a[0][1]).to eq('x')
      expect(grid.to_a[0][2]).to eq('-')
    end

    it 'doesnt alter the grid when column full' do
      100.times { grid.push('x', 0) }
      expect(grid.to_a[0].length).to eq(grid.height)
    end

    it 'raises when out of range' do
      expect { grid.push('o', 100) }.to raise_exception(ArgumentError)
      expect(grid.to_a).to all(all(be_nil))
    end
  end

  describe '#to_a' do
    subject { grid.to_a }

    let(:grid) { described_class.new(3, 3) }

    context 'when grid is empty' do
      it { is_expected.to be_an(Array) }
      it { is_expected.to all(all(be_nil)) }
    end

    context 'when grid is not empty' do
      before do
        %w[x x o].each { |token| grid.push(token, 0) }
        %w[x o o].each { |token| grid.push(token, 1) }
      end

      it { is_expected.to eq([%w[x x o], %w[x o o], [nil, nil, nil]])}
    end
  end
end
