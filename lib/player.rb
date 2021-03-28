class Player
  attr_accessor :name, :piece, :score

  def initialize(name, piece, score = 0)
    @name = name
    @piece = piece
    @score = score
  end

  def to_s
    name
  end
end
