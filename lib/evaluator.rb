# frozen_string_literal: true

module Mastermind
  # Takes guesses and code from game and passes back exact_matches, color_matches, and if win == true.
  # ONLY returns booleans, or number of exact/relative matches, nothing else.
  class Evaluator
    def valid_role?(selection)
      [1, 2].include?(selection)
    end

    def win?(code, guess)
      guess == code
    end

    def exact_matches(code, guess, code_remaining, guess_remaining)
      exact_matches = 0

      code.each_with_index do |value, index|
        if value == guess[index]
          exact_matches += 1
        else
          code_remaining << value
          guess_remaining << guess[index]
        end
      end

      exact_matches
    end

    def imperfect_matches(code_remaining, guess_remaining)
      imperfect_matches = 0

      guess_remaining.each do |value|
        if (match_index = code_remaining.index(value))
          imperfect_matches += 1
          code_remaining.delete_at(match_index)
        end
      end

      imperfect_matches
    end

    def match_feedback(code, guess)
      code_remaining = []
      guess_remaining = []

      [
        exact_matches(code, guess, code_remaining, guess_remaining),
        imperfect_matches(code_remaining, guess_remaining)
      ]
    end
  end
end
