# frozen_string_literal: true

module Mastermind
  # Ancestor class for human_player and computer_player
  class Player
    def initialize
      @white_pegs = []
      @black_pegs = []
    end

    def store_feedback
      raise NotImplementedError
    end

    def make_code
      raise NotImplementedError
    end

    def guess_code
      raise NotImplementedError
    end
  end
end
