class Grid
  attr_reader :columns, :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @columns = Array.new(width) { Array.new(height) }
  end

  def push(token, column)
    raise ArgumentError if column >= @width
    return if column_full?(column)

    @columns[column][next_row_index(column)] = token
  end

  # The grid consists of columns starting from bottom left:
  #  0,2 1,2 2,2
  #  0,1 1,1 2,1
  #  0,0 1,0 2,0
  def to_a
    @columns
  end

  private

  def column_full?(column)
    @columns[column][-1] != nil
  end

  def next_row_index(column)
    @columns[column].index(&:nil?)
  end
end

