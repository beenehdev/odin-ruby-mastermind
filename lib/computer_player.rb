# frozen_string_literal: true

require_relative 'player'

module Mastermind
  #
  class ComputerPlayer < Mastermind::Player
    attr_reader

    def initialize(value, foo)
      super(value)
      super(@code)
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
