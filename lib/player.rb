require "digest/sha2"
require_relative "turn"

class Player
  attr_reader :token

  def initialize
    # TODO: You better can prove ownership of your playing tokens
    @token = Digest::SHA256.hexdigest("H")
  end

  def produce_turn(game)
    # TODO: Your challenge is to produce your own good new turn
    # Hints:
    # - Use `game.grid` to find good positions
    # - Use `game.scoring_line_presences` to assess yours and others performance
    position = rand(0..game.grid.width - 1)

    Turn.new(token: @token, position: position)
  end
end
