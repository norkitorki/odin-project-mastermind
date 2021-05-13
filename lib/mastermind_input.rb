# module holding mastermind user input methods
module MastermindInput
  def player_input
    print "\n–> "
    gets.chomp.upcase
  end

  def request_game_mode
    game_mode = player_input.to_i until [1, 2].include?(game_mode)

    game_mode
  end

  def request_game_length
    game_count = player_input.to_i until game_count.to_i.positive?

    game_count
  end

  def replay_input
    continue = player_input until %w[Y N].include?(continue)

    continue
  end
end
