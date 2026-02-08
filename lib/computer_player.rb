# frozen_string_literal: true

require_relative 'player'

module Mastermind
  #
  class ComputerPlayer < Mastermind::Player
    def make_code
      result = []
      4.times { result << rand(1..6) }

      result
    end

    def guess_code
      raise NotImplementedError
      # Donald Knuth 5 or less minimax algorithm attempt
    end
  end
end
