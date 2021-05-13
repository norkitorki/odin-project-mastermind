require_relative '../lib/mastermind_board'

describe MastermindBoard do
  include MastermindPegs

  before(:all) do
    @mastermind_board = MastermindBoard.new
    @dummy_code       = MastermindPegs::COLOR_PEGS.shuffle[0..3]
  end

  it 'should initialize with default values' do
    expect(@mastermind_board.ranks).to eq(12)
    expect(@mastermind_board.files).to eq(4)
  end

  it 'should display the board' do
    expect(@mastermind_board.to_s).to eq(
      "Turn\n" \
      "    ┏━━━┯━━━┯━━━┯━━━┓\n" \
      " 12 ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 11 ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 10 ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 9  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 8  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 7  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 6  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 5  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 4  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 3  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 2  ┃   │   │   │   ┃ \n" \
      "    ┠───┼───┼───┼───┨\n" \
      " 1  ┃   │   │   │   ┃ \n" \
      "    ┗━━━┷━━━┷━━━┷━━━┛\n"
    )
  end

  it 'should place color and key pegs for a turn' do
    guess    = ['B', 'P', 'P', 'G']
    @mastermind_board.place_pegs(guess, @dummy_code, 10)

    expect(@mastermind_board.color_pegs(10)).to eq(guess)
  end

  it 'should return color pegs for a turn' do
    expect(@mastermind_board.color_pegs(10)).to eq(['B', 'P', 'P', 'G'])
  end

  it 'should return the key pegs for a turn' do
    guess = @mastermind_board.color_pegs(10)
    response = key_peg_response(guess, @dummy_code)

    expect(@mastermind_board.key_pegs(10).sort).to eq(response.sort)
  end
end
