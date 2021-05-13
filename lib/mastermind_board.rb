require_relative 'game_board'
require_relative 'mastermind_pegs'

# mastermind terminal game board
class MastermindBoard < GameBoard
  include MastermindPegs

  def initialize(ranks: 12, files: 4)
    @key_pegs = Array.new(ranks, [])
    super
  end

  def to_s
    "Turn\n" << colorize_color_pegs(super.lines[0..-2].join)
  end

  def place_pegs(guess, code, turn)
    file = :A

    guess.each do |peg|
      field("#{file}#{turn}".to_sym, peg)
      file = file.next
    end

    place_key_pegs(guess, code, turn)
  end

  def place_key_pegs(guess, code, turn)
    @key_pegs[ranks - turn] = key_peg_response(guess, code)
  end

  def color_pegs(turn)
    rows[turn - 1]
  end

  def key_pegs(turn)
    @key_pegs[ranks - turn]
  end

  private

  def board
    super.map.with_index do |row, i|
      row.chomp << ' ' << @key_pegs[i].join('  ') << "\n"
    end
  end

  def board_offset
    ' ' * 4
  end
end
