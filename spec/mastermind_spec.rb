require_relative '../lib/mastermind'

describe Mastermind do
  include MastermindMessages
  include MastermindInput
  include MastermindPegs

  let(:mastermind) { Mastermind.new('John') }

  context 'play' do
    it 'should setup and start the game' do
      allow(mastermind).to receive(:request_game_mode).and_return(2)
      allow(mastermind).to receive(:request_game_length).and_return(4)
      allow(mastermind).to receive(:begin_game).with(4)
      allow(mastermind).to receive(:replay_input).and_return('N')
      mastermind.play
    end
  end

  context '#input' do
    describe 'player_input' do
      it 'should return user input capitalized' do
        allow(mastermind).to receive(:gets).and_return('a')
        expect(mastermind.player_input).to eq('A')
      end
    end

    describe 'request_game_mode' do
      it 'should return either 1 or 2' do
        allow(mastermind).to receive(:player_input).and_return(10, -24, 1, 2)
        expect(mastermind.request_game_mode).to eq(1)
        expect(mastermind.request_game_mode).to eq(2)
      end
    end

    describe 'request_game_length' do
      it 'should only return postive integers' do
        allow(mastermind).to receive(:player_input).and_return(-10, 4, 0, 10)
        expect(mastermind.request_game_length).to eq(4)
        expect(mastermind.request_game_length).to eq(10)
      end
    end

    describe 'replay_input' do
      it "should return either 'Y' or 'N'" do
        allow(mastermind).to receive(:player_input).and_return(4, 'y', 'Y', 'N')
        expect(mastermind.replay_input).to eq('Y')
        expect(mastermind.replay_input).to eq('N')
      end
    end
  end

  context '#Pegs' do
    describe 'colorize_peg' do
      it 'should return a specific color peg' do
        color_pegs = MastermindPegs::COLOR_PEGS
        expect(colorize_peg(color_pegs[0])).to eq("\e[0;34;49m\u2B24\e[0m")
        expect(colorize_peg(color_pegs[1])).to eq("\e[0;36;49m\u2B24\e[0m")
        expect(colorize_peg(color_pegs[2])).to eq("\e[0;32;49m\u2B24\e[0m")
        expect(colorize_peg(color_pegs[3])).to eq("\e[0;33;49m\u2B24\e[0m")
        expect(colorize_peg(color_pegs[4])).to eq("\e[0;35;49m\u2B24\e[0m")
        expect(colorize_peg(color_pegs[5])).to eq("\e[0;31;49m\u2B24\e[0m")
        expect(colorize_peg(5)).to eq(5)
        expect(colorize_peg('BP')).to eq('BP')
      end
    end

    describe 'key_peg_response' do
      it 'should return an unordered key peg response' do
        guess = %w[R R B B]
        code  = %w[B B B R]
        expect(key_peg_response(guess, code)).to include(
          "\e[0;31;49m\u25C9\e[0m", ' ', "\u25C9"
        )
      end
    end

    describe 'user_input_options' do
      it 'should display every color peg input option' do
        color_pegs = MastermindPegs::COLOR_PEGS
        expect(user_input_options).to eq(
          "#{color_pegs[0]} for #{colorize_peg(color_pegs[0])} | " \
          "#{color_pegs[1]} for #{colorize_peg(color_pegs[1])} | " \
          "#{color_pegs[2]} for #{colorize_peg(color_pegs[2])} | " \
          "#{color_pegs[3]} for #{colorize_peg(color_pegs[3])} | " \
          "#{color_pegs[4]} for #{colorize_peg(color_pegs[4])} | " \
          "#{color_pegs[5]} for #{colorize_peg(color_pegs[5])}"
        )
      end
    end

    describe 'colorize_color_pegs' do
      it 'should convert color peg keys to color pegs' do
        expect(colorize_color_pegs('s B a 2 p O k 43 j g')).to eq(
          "s \e[0;34;49m\u2B24\e[0m a 2 \e[0;35;49m\u2B24\e[0m" \
          " \e[0;33;49m\u2B24\e[0m k 43 j \e[0;32;49m\u2B24\e[0m"
        )
      end
    end

    describe 'code_display' do
      it 'should display colored pegs' do
        guess = %w[P G R B]
        expect(code_display(guess)).to eq(
          "\e[0;35;49m\u2B24\e[0m  \e[0;32;49m\u2B24\e[0m" \
          "  \e[0;31;49m\u2B24\e[0m  \e[0;34;49m\u2B24\e[0m"
        )
      end
    end

    describe 'code_input' do
      it 'should prompt the user for and return only valid code input' do
        allow(mastermind).to receive(:gets).and_return(
          'R', 'o', '0', 'g', 'X', 'p'
        )
        expect(mastermind.code_input).to eq(%w[R O G P])
      end
    end
  end

  context '#Messages' do
    describe 'game_instructions' do
      it 'should display instructions' do
        expect(game_instructions).to eq(
          <<~INSTRUCTIONS
            ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
            \e[4;39;49mWelcome to Mastermind!\e[0m

            In Mastermind the Codemaster will set up a code sequence consisting of four colored pegs.
            The color pegs are defined as follows: \e[0;34;49m⬤\e[0m \e[0;36;49m⬤\e[0m \e[0;32;49m⬤\e[0m \e[0;33;49m⬤\e[0m \e[0;35;49m⬤\e[0m \e[0;31;49m⬤\e[0m

            The Codebreaker's task is to guess the correct color peg sequence in 12 turns.
            After each guess made,the game will provide a key peg response of either \e[0;31;49m\u25C9\e[0m or \u25C9

            A red key peg indicates that a color peg is at the right position.
            A white key peg indicates that a color peg is at the wrong position.
            Keep in mind though that the key pegs are not ordered.

            You can either play as the Codemaster to set up the code and let the Computer act as the Codebreaker, or
            you can play as the Codebreaker and let the Computer set up the code.

            Good Luck!
            –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

          INSTRUCTIONS
        )
      end
    end

    describe 'player_code_message' do
      it 'should prompt the player to set up the code' do
        player = mastermind.player
        input_options = user_input_options
        expect(player_code_message(player, input_options)).to eq(
          "\nJohn, please set up the code.\n\nInput #{user_input_options}\n\n"
        )
      end
    end

    describe 'codebreaker_input_message' do
      it 'should prompt the player to set up a code guess' do
        codebreaker   = mastermind.player
        input_options = user_input_options
        expect(codebreaker_input_message(codebreaker, input_options)).to eq(
          "\nJohn's turn.\n\nInput #{user_input_options}\n\n"
        )
      end
    end

    describe 'game_count_message' do
      it 'should display the current game count' do
        index       = 1
        game_length = 5
        expect(game_count_message(index, game_length)).to eq("\nGame 1 of 5")
      end
    end

    describe 'computer_loading_message' do
      it 'should display a message indicating that the computer is loading' do
        expect(computer_loading_message).to eq(
          "\nThe Computer is generating the next guess." \
          ' This might take a while...'
        )
      end
    end

    describe 'computer_input_message' do
      it 'should display the guess selected by the computer' do
        computer_guess = code_display(%w[R B P R])
        expect(computer_input_message(computer_guess)).to eq(
          "\nThe computer's guess: #{code_display(%w[R B P R])}"
        )
      end
    end

    describe 'replay_message' do
      it 'should prompt the user to replay or quit the game' do
        expect(replay_message).to eq(
          "\nWould you like to play another game? (y/n)"
        )
      end
    end

    describe 'code_solved_message' do
      it 'should display a message if the code has been solved' do
        codebreaker = mastermind.player
        expect(code_solved_message(codebreaker)).to eq(
          "\e[0;32;49m\nJohn has cracked the code!\e[0m"
        )
      end
    end

    describe 'code_unsolved_message' do
      it 'should display a message if the code has not been solved' do
        codebreaker = 'The Computer'
        code        = code_display(%w[R B P B])
        expect(code_unsolved_message(codebreaker, code)).to eq(
            "\e[0;33;49m\nThe Computer was unable to crack the code.\e[0m" \
            "\n\nThe code was #{code}"
        )
      end
    end

    describe 'final_score_message' do
      it 'should display the final score' do
        player = mastermind.player
        points = 14
        expect(final_score_message(player, points)).to eq(
          "\nJohn has scored 14 points!"
        )
      end
    end
  end
end
