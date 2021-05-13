require_relative '../lib/mastermind_computer'

describe MastermindComputer do
  include MastermindPegs

  before(:all) { @computer = MastermindComputer.new }

  def valid_guess?(guess)
    guess.all?(/[#{MastermindPegs::COLOR_PEGS}]/) && guess.length == 4
  end

  context 'guess method' do
    it 'should return a guess' do
      expect(valid_guess?(@computer.guess(1))).to eq(true)
    end

    it 'should return nil for an unset guess' do
      expect(@computer.guess(12)).to eq(nil)
    end
  end

  it 'should find the next guess' do
    dummy_code = %w[R C P G]
    key_pegs   = key_peg_response(@computer.guess(1), dummy_code)
    @computer.next_guess(1, key_pegs)

    expect(valid_guess?(@computer.guess(2))).to eq(true)
  end

  it 'should reset the state' do
    @computer.reset

    expect(@computer.combinations.length).to eq(1296)
    expect(@computer.selection.length).to eq(1296)
    expect(@computer.guesses.length).to eq(1)
  end
end
