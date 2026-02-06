# frozen_string_literal: true

require_relative 'evaluator'

module Mastermind
  # Main logic of game-handling
  class Game
    attr_reader :guesses

    def initialize(player1, player2, interactive: false)
      @evaluator = Mastermind::Evaluator.new
      @guesses = []
      @exact_matches = []
      @color_matches = []
      @rounds = 8

      @player1 = player1
      @player2 = player2

      preset_roles(interactive)
    end

    def preset_roles(interactive)
      if interactive
        select_roles(@player1, @player2)
      else
        @code_maker = @player1
        @code_breaker = @player2
      end
    end

    def assign_roles(selection, player1, player2)
      case selection
      when 1
        @code_breaker = player1
        @code_maker = player2
      when 2
        @code_breaker = player2
        @code_maker = player1
      end
    end

    def select_roles(player1, player2)
      puts 'Welcome to MASTERMIND:'

      loop do
        puts "Please select who will be the codebreaker, 1 for #{player1} or 2 for #{player2}."
        selection = gets.trim.to_i

        valid = @evaluator.validate_roles(selection)
        assign_roles(selection, player1, player2)
        break if valid

        warns 'Invalid Input.'
      end
    end

    def start
      puts "#{@code_breaker} will be codebreaker, and #{@code_maker} will be mastermind."
      puts 'Is this correct? Y/N.'
      confirm = gets.trim.downcase
      confirm == 'y' ? play : select_roles(@player1, @player2)
    end

    def play
      code = @code_maker.make_code

      1.upto(@rounds) do |round_num|
        latest_guess = @code_breaker.guess_code
        @guesses << latest_guess

        game_end && break if @evaluator.win?(latest_guess, code)

        @exact_matches = ''
        @color_matches = ''
      end
    end
  end
end
