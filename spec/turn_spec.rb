require_relative '../lib/turn'

RSpec.describe Turn do
  describe '#new' do
    subject { described_class.new(token: 'o', position: 42) }

    it { is_expected.to have_attributes(token: 'o', position: 42) }
  end

  describe '#to_s' do
    subject { described_class.new(token: 'X', position: 11).to_s }

    it { is_expected.to eq("X 11") }
  end

  describe '#from_str' do
    subject { described_class.from_str('x 23') }

    it { is_expected.to be_a(described_class) }
    it { is_expected.to have_attributes(token: 'x', position: 23) }
  end
end
