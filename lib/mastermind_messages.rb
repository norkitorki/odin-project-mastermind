# console messages for Mastermind
module MastermindMessages
  def game_instructions
    <<~INSTRUCTIONS
      ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
      \e[4;39;49mWelcome to Mastermind!\e[0m

      In Mastermind the Codemaster will set up a code sequence consisting of four colored pegs.
      The color pegs are defined as follows: \e[0;34;49m⬤\e[0m \e[0;36;49m⬤\e[0m \e[0;32;49m⬤\e[0m \e[0;33;49m⬤\e[0m \e[0;35;49m⬤\e[0m \e[0;31;49m⬤\e[0m

      The Codebreaker's task is to guess the correct color peg sequence in 12 turns.
      After each guess made,the game will provide a key peg response of either \e[0;31;49m\u25C9\e[0m or \u25C9

      A red key peg indicates that a color peg is at the right position.
      A white key peg indicates that a color peg is included in the code,but placed at the wrong position.
      If a color peg is not included in the code, no key peg will be placed.
      Please note that the key pegs are not ordered.

      You can either play as the Codemaster to set up the code and let the Computer act as the Codebreaker, or
      you can play as the Codebreaker and let the Computer set up the code.

      Good Luck!
      ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

    INSTRUCTIONS
  end

  def game_mode_message
    "Would you like to play as the Codemaster or Codebreaker?\n" \
      "\n'1' to play as the Codemaster  (decide the code)" \
      "\n'2' to play as the Codebreaker (break the code)"
  end

  def game_length_message
    'How many games would you like to play?'
  end

  def player_code_message(player, input_options)
    "\n#{player}, please set up the code.\n\nInput #{input_options}\n\n"
  end

  def codebreaker_input_message(codebreaker, input_options)
    "\n#{codebreaker}'s turn.\n\nInput #{input_options}\n\n"
  end

  def game_count_message(index, game_length)
    "\nGame #{index} of #{game_length}"
  end

  def computer_input_message(computer_guess)
    "\nThe Computer's guess: #{computer_guess}"
  end

  def replay_message
    "\nWould you like to play another game? (y/n)"
  end

  def code_solved_message(codebreaker)
    "\e[0;32;49m\n#{codebreaker} has cracked the code!\e[0m"
  end

  def code_unsolved_message(codebreaker, code)
    "\e[0;33;49m\n#{codebreaker} was unable to crack the code.\e[0m" \
    "\n\nThe code was #{code}"
  end

  def final_score_message(player, points)
    "\n#{player} has scored #{points} points!"
  end
end
