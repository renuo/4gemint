class Grid
  attr_reader :columns, :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @columns = Array.new(width) { Array.new(height) }
  end

  def push(color, column)
    return if column_full?(column)

    @columns[column][next_row_index(column)] = color
  end

  def to_a
    @columns
  end

  private

  def column_full?(column)
    @columns[column][0] != nil
  end

  def next_row_index(column)
    @columns[column].rindex(&:nil?)
  end
end

