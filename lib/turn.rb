class Turn
  attr_accessor :token, :position

  def initialize(token:, position:)
    @token = token
    @position = position
  end

  def to_s
    "#{@token} #{@position}"
  end

  def self.from_str(str)
    token, position = str.split
    Turn.new(token: token, position: position.to_i)
  end
end
