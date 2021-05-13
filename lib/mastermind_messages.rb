# console messages for Mastermind
module MastermindMessages
  def game_mode_message
    "Would you like to play as the Codemaster or Codebreaker?\n" \
      "\n'1' to play as the Codemaster  (decide the code)" \
      "\n'2' to play as the Codebreaker (break the code)"
  end

  def game_length_message
    'How many games would you like to play?'
  end

  def player_code_message(player, input_options)
    "\n#{player}, please set up the code.\n\nInput #{input_options}\n"
  end

  def codebreaker_input_message(codebreaker, input_options)
    "\n#{codebreaker}'s turn.\n\nInput #{input_options}\n"
  end

  def game_count_message(index, game_length)
    "\nGame #{index} of #{game_length}"
  end

  def computer_loading_message
    "\nThe Computer is generating the next guess. This might take a while..."
  end

  def computer_input_message(computer_guess)
    "\nThe computer's guess: #{computer_guess}"
  end

  def replay_message
    "\nWould you like to play another game? (y/n)"
  end

  def code_solved_message(codebreaker)
    "\e[0;32;49m\n#{codebreaker} has cracked the code!\e[0m"
  end

  def code_unsolved_message(codebreaker)
    "\e[0;33;49m\n#{codebreaker} was unable to crack the code.\e[0m"
  end

  def final_score_message(player, points)
    "\n#{player} has scored #{points} points!"
  end
end
