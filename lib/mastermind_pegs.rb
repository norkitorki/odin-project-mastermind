# mastermind pegs container
module MastermindPegs
  COLOR_PEGS = %w[B C G O P R].freeze

  KEY_PEGS = {
    red: "\e[0;31;49m\u25C9\e[0m", white: "\u25C9", empty: ' '
  }.freeze

  def colorize_peg(peg)
    colors = { B: 34, C: 36, G: 32, O: 33, P: 35, R: 31 }

    peg_sym = peg.to_s.upcase.to_sym
    colors.key?(peg_sym) ? "\e[0;#{colors[peg_sym]};49m\u2B24\e[0m" : peg
  end

  def key_peg_response(guess, code)
    guess.map.with_index do |peg, i|
      if guess[..i].count(peg) <= code.count(peg)
        next KEY_PEGS[:red] if code[i] == peg
        next KEY_PEGS[:white] if code.include?(peg)
      end

      KEY_PEGS[:empty]
    end.shuffle
  end

  def code_input
    code = []

    4.times do |i|
      print '–> '
      code[i] = gets.chomp.upcase until COLOR_PEGS.include?(code[i])
      puts code_display(code)
    end

    code
  end

  def colorize_color_pegs(str)
    str.gsub(/#{COLOR_PEGS}/i) { |match| colorize_peg(match) }
  end

  def code_display(code)
    colorize_color_pegs(code.join('  '))
  end

  def user_input_options
    COLOR_PEGS.map { |c| "#{c} for #{colorize_peg(c)}" }.join(' | ')
  end
end
