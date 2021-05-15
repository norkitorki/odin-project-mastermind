require_relative 'mastermind_pegs'

# computer opponent for Mastermind
class MastermindComputer
  include MastermindPegs

  attr_reader :combinations
  attr_accessor :selection, :guesses

  def initialize
    @combinations = COLOR_PEGS.repeated_permutation(4).to_a
    @selection    = combinations[0..]
    @guesses      = { 1 => combinations.sample }
  end

  def guess(turn)
    guesses[turn]
  end

  def next_guess(turn, key_peg_response)
    # remove the current guess from the sets of codes
    remove_code_guess(guess(turn), combinations, selection)

    # repopulate the selection if the computer was not able to break the code
    self.selection = combinations[0..] if selection.empty?

    # remove codes with a different key peg response
    remove_codes_with_different_response(guess(turn), key_peg_response)

    # pick and store the next guess
    guesses[turn + 1] = selection.sample
  end

  def reset
    initialize
  end

  private

  def remove_code_guess(code, *selections)
    selections.each { |set| set.delete(code) }
  end

  def remove_codes_with_different_response(guess, key_pegs)
    key_pegs.sort!
    selection.select! do |code|
      current_key_pegs = key_peg_response(guess, code).sort
      current_key_pegs.eql?(key_pegs)
    end
  end
end
