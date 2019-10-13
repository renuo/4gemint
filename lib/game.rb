require_relative 'grid'

class Game
  attr_accessor :grid

  def initialize(width:, height:, scoring_line_length: 4)
    @scoring_line_length = scoring_line_length
    @grid = Grid.new(width, height)
  end

  def submit(turn)
    @grid.push(turn.token, turn.position) || raise('column full')
  end

  def scoring_line_presences
    scoring_row_presences + scoring_column_presences + scoring_downward_diag_presences + scoring_upward_diag_presences
  end

  private

  def scoring_row_presences
    @grid.columns.transpose.flat_map { |row| extract_scoring_lines(row) }
  end

  def scoring_column_presences
    @grid.columns.flat_map { |column| extract_scoring_lines(column) }
  end

  def scoring_downward_diag_presences
    padding = [*0..(@grid.columns.length - 1)].map { |i| [nil] * i }
    padded = padding.reverse.zip(@grid.columns).zip(padding).map(&:flatten)
    padded.transpose.map(&:compact).flat_map { |diag| extract_scoring_lines(diag) }
  end

  def scoring_upward_diag_presences
    padding = [*0..(@grid.columns.length - 1)].map { |i| [nil] * i }
    padded = padding.zip(@grid.columns).zip(padding.reverse).map(&:flatten)
    padded.transpose.map(&:compact).flat_map { |diag| extract_scoring_lines(diag) }
  end

  def extract_scoring_lines(line)
    line.each_with_index
      .chunk { |(x, _i)| x }
      .map { |(sample, matches)| [sample, matches[0][-1], matches.length] }
      .select { |c| c.last >= @scoring_line_length }
  end
end
