# frozen_string_literal: true

module Mastermind
  # Main logic of game-handling
  class Game
    attr_reader :guesses

    def initialize(player1, player2, interactive: false)
      @rounds = 8
      @player1 = player1
      @player2 = player2
      if interactive
        select_roles(@player1, @player2)
      else
        @code_maker = @player1
        @code_breaker = @player2
      end
    end

    def validate_role(selection, player1, player2)
      return if [1, 2].include?(selection)

      puts "Invalid Input: Please enter 1 for #{player1} or 2 for #{player2} to select who will be codebreaker."
      select_roles(player1, player2)
    end

    def assign_role(selection, player1, player2)
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
      puts "Please select who will be the codebreaker, 1 for #{player1} or 2 for #{player2}."
      selection = gets.trim.downcase

      validate_role(selection, player1, player2)
      assign_role(selection, player1, player2)
    end

    def start
      puts "#{@code_breaker} will be codebreaker, and #{@code_maker} will be mastermind."
      puts 'Is this correct? Y/N.'
      confirm = gets.trim.downcase
      confirm == 'y' ? play : select_roles(@player1, @player2)
    end

    def play
      code = @code_maker.make_code
      guesses = []

      @rounds.times do
        guesses << @code_breaker.guess_code
        next unless play_assessment(guesses, code) == 'win'

        game_end
        break
      end
    end

    def play_assessment(guesses, code)
      return 'win' if code.all?(guesses[-1])

      guesses
    end
  end
end
