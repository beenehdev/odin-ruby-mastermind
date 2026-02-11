# frozen_string_literal: true

require_relative './player'

module Mastermind
  #
  class HumanPlayer < Player
    def store_feedback(exact_matches, imperfect_matches)
      print_feedback(exact_matches, imperfect_matches)
    end

    def print_feedback(exact_matches, imperfect_matches)
      puts "Your guess had #{exact_matches} exact matches and #{imperfect_matches} imperfect matches."
    end

    def make_code
      result = []
      puts 'Make a code:'
      puts 'Enter a 4 digit code of numbers between 1-6. Example: 1266'
      loop do
        result = parse_input
        return result if valid_input?(result)

        puts 'Invalid input:'
      end
    end

    def guess_code
      result = []
      puts 'Time to guess!'
      puts 'Enter a 4 digit code of numbers between 1-6. Example: 1266'
      loop do
        result = parse_input
        return result if valid_input?(result)

        puts 'Invalid input:'
      end
    end

    def parse_input
      gets.strip.chars.map(&:to_i)
    end

    def valid_input?(result)
      result.length == 4 &&
        result.all? { |value| value.is_a?(Integer) && (1..6).include?(value) }
    end
  end
end
