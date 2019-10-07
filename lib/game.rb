require_relative 'grid'

class Game
  attr_accessor :grid

  def initialize(scoring_line_legnth = 4)
    @scoring_line_length = scoring_line_legnth
    @grid = Grid.new(10, 10)
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
    columns = @grid.columns

    pad = [*0..(columns.length - 1)].map { |i| [nil] * i }
    padded = pad.reverse.zip(columns).zip(pad).map(&:flatten)
    padded.transpose.map(&:compact).flat_map { |diag| extract_scoring_lines(diag) }
  end

  def scoring_upward_diag_presences
    columns = @grid.columns

    pad = [*0..(columns.length - 1)].map { |i| [nil] * i }
    padded = pad.zip(columns).zip(pad.reverse).map(&:flatten)
    padded.transpose.map(&:compact).flat_map { |diag| extract_scoring_lines(diag) }
  end

  def extract_scoring_lines(line)
    line.each_with_index
      .chunk { |(x, _i)| x }
      .map { |(sample, matches)| [sample, matches[0][-1], matches.length] }
      .select { |c| c.last >= @scoring_line_length }
  end
end
