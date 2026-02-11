# frozen_string_literal: true

require_relative './player'
require_relative './evaluator'

module Mastermind
  # ComputerPlayer logic and handling
  class ComputerPlayer < Player
    def initialize
      super
      @evaluator = Mastermind::Evaluator.new
      possibilities = (1..6).to_a.repeated_permutation(4).to_a
      @all_answers = possibilities
      @all_guesses = possibilities.dup
      @guess_num = 0
      @guess = []
    end

    def store_feedback(exact_matches, imperfect_matches)
      @black_pegs = exact_matches
      @white_pegs = imperfect_matches
    end

    def make_code
      result = []
      4.times { result << rand(1..6) }

      result
    end

    def score_guess(guess, possible_answers)
      response_groups = Hash.new(0)

      possible_answers.each do |code|
        response = @evaluator.match_feedback(code, guess)
        response_groups[response] += 1
      end

      response_groups.values.max
    end

    def choose_best_guess
      best_score = Float::INFINITY
      best_guess = nil

      @all_guesses.each do |guess|
        score = score_guess(guess, @all_answers)

        next unless score < best_score ||
                    (score == best_score && @all_answers.include?(guess))

        best_score = score
        best_guess = guess
      end

      best_guess
    end

    def guess_code
      # Donald Knuth 5 or less minimax algorithm attempt
      if @guess_num.zero?
        @guess_num += 1
        @guess = [1, 1, 2, 2]
        puts "The computer guesses: #{@guess}"
        return @guess = [1, 1, 2, 2]
      end

      @all_answers.select! do |possible_code|
        @evaluator.match_feedback(possible_code, @guess) == [@black_pegs, @white_pegs]
      end

      @guess = choose_best_guess
      @guess_num += 1

      puts "The computer guesses: #{@guess}"
      @guess
    end
  end
end
