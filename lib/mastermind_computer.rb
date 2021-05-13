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

    # repopulate the set if the computer was not able to break the code
    self.selection = combinations[0..] if selection.empty?

    # remove codes with a different key peg response
    remove_codes_with_different_response(guess(turn), key_peg_response)

    # store the min(max) results
    minmax_set = find_minmax

    # find and store the next guess
    guesses[turn + 1] = select_next_guess(minmax_set)
  end

  def reset
    initialize
  end

  private

  def remove_code_guess(code, *selections)
    selections.each { |set| set.delete(code) }
  end

  def remove_codes_with_different_response(guess, current_key_pegs)
    current_key_pegs.sort!
    selection.select! do |code|
      key_pegs = key_peg_response(guess, code).sort
      key_pegs.eql?(current_key_pegs)
    end
  end

  def find_minmax
    minmax = {}

    combinations.each do |option|
      hit_count = Hash.new(0)

      selection.each do |code|
        key_pegs = key_peg_response(code, option).sort
        hit_count[key_pegs] += 1
      end

      minmax[option] = hit_count.values.max
    end

    find_min_scores(minmax)
  end

  def find_min_scores(scores_set)
    scores_set.select { |_, count| count == scores_set.values.min }.keys
  end

  def select_next_guess(codes)
    codes.each { |code| return code if selection.include?(code) }
    codes.sample
  end
end
