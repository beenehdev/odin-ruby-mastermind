# frozen_string_literal: true

module Mastermind
  # Takes guesses and code from game and passes back exact_matches, color_matches, and if win == true.
  # ONLY returns booleans, or number of exact/relative matches, nothing else.
  class Evaluator
    def initialize(foo, bar)
      @foo = foo
      @bar = bar
    end

    def valid_role?(selection)
      true if [1, 2].include?(selection)
    end

    def win?(latest_guess, code)
      code.all?(latest_guess)
    end

    def save_matches(code, latest_guess, round_num)
      code.each_with_index do |value, index|
        if value == latest_guess[index]
          @exact_matches[round_num - 1] += 1

        elsif latest_guess.any?(code[index])
          @color_matches[round_num - 1] += 1
        end
      end
    end
  end
end
