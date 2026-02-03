# frozen_string_literal: true

module Mastermind
  # Main logic of game-handling
  class Game
    def initialize(code_maker, code_breaker)
      @code_maker = code_maker
      @code_breaker = code_breaker
    end
  end
end
