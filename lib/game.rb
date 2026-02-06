# frozen_string_literal: true

module Mastermind
  # Main logic of game-handling
  class Game
    attr_reader :guesses

    def initialize(player1, player2, interactive: false)
      @guesses = Array.new(0)
      @exact_matches = Array.new(0, 0)
      @color_matches = Array.new(0, 0)
      @rounds = 8
      @current_round = 1

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
      selection = gets.trim.to_i

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

      @rounds.times do
        @current_round += 1
        @guesses << @code_breaker.guess_code
        next unless play_assessment(@guesses, code) == 'win'

        game_end
        break
      end
    end

    def save_matches(code, latest_guess, latest_index)
      code.each_with_index do |_value, index|
        if code[index] == latest_guess[index]
          @exact_matches[latest_index] += 1
          next
        elsif latest_guess.any?(code[index])
          @color_matches[latest_index] += 1
          next
        end
      end
    end

    def play_assessment(guesses, code)
      latest_guess = guesses[@current_round - 1]
      latest_index = guesses[@current_round - 1].index

      return 'win' if code.all?(latest_guess)

      save_matches(code, latest_guess, latest_index)
    end
  end
end
