# frozen_string_literal: true

require_relative './player'

module Mastermind
  # ComputerPlayer logic and handling
  class ComputerPlayer < Player
    def make_code
      result = []
      4.times { result << rand(1..6) }

      result
    end

    def guess_code
      raise NotImplementedError
      # Donald Knuth 5 or less minimax algorithm attempt
    end

    def store_feedback
      raise NotImplementedError
    end
  end
end
