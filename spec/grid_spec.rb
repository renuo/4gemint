require_relative '../lib/grid'

RSpec.describe Grid do
  it 'can initialize' do
    Grid.new(10, 10)
  end
end
