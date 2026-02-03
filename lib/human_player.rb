# frozen_string_literal: true

require_relative 'player'

module Mastermind
  # Ancestor class for human_player and computer_player
  class HumanPlayer < Mastermind::Player
    attr_reader

    def initialize(value, foo)
      super(value)
      @foo = foo
    end

    def make_code
      raise NotImplementedError
    end

    def guess_code
      raise NotImplementedError
    end
  end
end
