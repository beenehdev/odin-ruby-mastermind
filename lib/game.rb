# frozen_string_literal: true

require_relative './evaluator'

module Mastermind
  # Main logic of game-handling
  class Game
    attr_reader :guesses

    def initialize(player1, player2, interactive: false)
      @evaluator = Mastermind::Evaluator.new
      @guesses = []
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
        selection = gets.strip.to_i

        valid = @evaluator.valid_role?(selection)
        assign_roles(selection, player1, player2)
        if valid
          start
          return
        end

        warns 'Invalid Input:'
      end
    end

    def start
      puts "#{@code_breaker} will be codebreaker, and #{@code_maker} will be mastermind."
      puts 'Is this correct? Y/N.'

      confirm = gets.strip.downcase
      confirm == 'y' ? play : select_roles(@player1, @player2)
    end

    def guess_feedback(code, guess)
      exact_matches, imperfect_matches = @evaluator.match_feedback(code, guess)

      @code_breaker.store_feedback(exact_matches, imperfect_matches)
    end

    def codebreaker_win
      puts 'This is where the game STOPS! The codebreaker won!'
    end

    def mastermind_win
      puts 'This is where the game STOPS! The mastermind won!'
    end

    def play
      code = @code_maker.make_code

      1.upto(@rounds) do |round_num|
        guess = @code_breaker.guess_code
        @guesses << guess

        if @evaluator.win?(code, guess)
          codebreaker_win
          break
        end

        if round_num == @rounds
          mastermind_win
          break
        end

        guess_feedback(code, guess)
      end
    end
  end
end
