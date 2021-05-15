require_relative 'mastermind_board'
require_relative 'mastermind_computer'
require_relative 'mastermind_messages'
require_relative 'mastermind_input'
require_relative 'mastermind_pegs'

# base class for a mastermind terminal game
class Mastermind
  include MastermindMessages
  include MastermindInput
  include MastermindPegs

  attr_reader :player, :turn

  def initialize(player)
    @player      = player
    @computer    = MastermindComputer.new
    @board       = MastermindBoard.new
    @guess       = []
    @code        = []
    @turn        = 1
    puts game_instructions
  end

  def play
    puts game_mode_message
    self.game_mode = request_game_mode
    self.score     = 0

    puts game_length_message
    game_length = request_game_length

    begin_game(game_length)

    puts final_score_message(player, score)
    replay
  end

  private

  attr_reader :computer, :board
  attr_accessor :guess, :code, :game_mode, :score

  def begin_game(game_length)
    game_length.times do |i|
      setup_code
      puts game_count_message(i + 1, game_length)
      game
    end
  end

  def setup_code
    if game_mode == 1
      puts player_code_message(player, user_input_options)
      self.code = code_input
    else
      self.code = computer.guess(turn)
    end
  end

  def game
    game_mode == 1 ? computer_guess : codebreaker_guess

    system 'clear'
    puts board
    return game_over if code_solved? || board.full?

    @turn += 1
    game
  end

  def computer_guess
    self.guess = computer.guess(turn)

    board.place_pegs(guess, code, turn)
    next_computer_guess(turn)

    puts computer_input_message(code_display(guess))
    sleep 2
  end

  def next_computer_guess(turn)
    computer.next_guess(turn, board.key_pegs(turn))
  end

  def codebreaker_guess
    puts codebreaker_input_message(player, user_input_options)

    self.guess = code_input
    board.place_pegs(guess, code, turn)
  end

  def game_over
    update_score

    codebreaker = game_mode == 1 ? 'The Computer' : player
    if code_solved?
      puts code_solved_message(codebreaker)
    else
      puts code_unsolved_message(codebreaker, code_display(code))
    end

    reset_game
  end

  def update_score
    score = game_mode == 1 ? turn : 12 - turn
    self.score += score if game_mode == 1 || code_solved?
  end

  def code_solved?
    guess.eql?(code)
  end

  def reset_game
    computer.reset
    board.clear
    @turn = 1
  end

  def replay
    self.game_mode = 0
    puts replay_message

    play if replay_input == 'Y'
  end
end
