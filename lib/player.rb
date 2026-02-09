# frozen_string_literal: true

module Mastermind
  # Ancestor class for human_player and computer_player
  class Player
    def make_code
      raise NotImplementedError
    end

    def guess_code
      raise NotImplementedError
    end

    def store_feedback
      raise NotImplementedError
    end
  end
end
