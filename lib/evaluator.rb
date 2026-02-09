# frozen_string_literal: true

module Mastermind
  # Takes guesses and code from game and passes back exact_matches, color_matches, and if win == true.
  # ONLY returns booleans, or number of exact/relative matches, nothing else.
  class Evaluator
    def initialize
      @code_remaining = []
      @guess_remaining = []
    end

    def valid_role?(selection)
      true if [1, 2].include?(selection)
    end

    def win?(latest_guess, code)
      code.all?(latest_guess)
    end

    def exact_matches(code, latest_guess)
      exact_matches = 0

      code.each_with_index do |value, index|
        if value == latest_guess[index]
          exact_matches += 1
        else
          @code_remaining << value
          @guess_remaining << latest_guess[index]
        end
      end

      exact_matches
    end

    def imperfect_matches
      imperfect_matches = 0

      @guess_remaining.each do |value|
        if (match_index = @code_remaining.index(value))
          imperfect_matches += 1
          @code_remaining.delete_at(match_index)
        end
      end

      imperfect_matches
    end
  end
end
