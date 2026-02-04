# frozen_string_literal: true

module Mastermind
  # Main logic of game-handling
  class Game
    def initialize(player1, player2, interactive: false)
      @player1 = player1
      @player2 = player2
      if interactive
        select_roles(@player1, @player2)
      else
        @code_maker = @player1
        @code_breaker = @player2
      end
    end

    def start; end
  end
end
