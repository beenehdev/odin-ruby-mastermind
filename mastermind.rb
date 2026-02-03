# frozen_string_literal: true

# OBJECTIVE: MASTERMIND.

# CRITERIA:
# 1. COMPUTER RANDOMLY SELECTS SECRET COLORS. HUMAN PLAYER MUST GUESS THEM. FEEDBACK BASED ON HOW GOOD GUESS WAS
# 2. AFTER COMPLETE FIRST GOAL, ALLOW HUMAN PLAYER TO SELECT IF THEY ARE CODEBREAKER OR MASTERMIND
# 3. ADD COMPUTER ALOGIRTHM FOR GUESSING
# 4. IMPLEMENT COMPUTER ALGORITHM WITH OPTIMAL MASTERMIND STRATEGY

require_relative 'player'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'game'

player = Mastermind::HumanPlayer.new
computer = Mastermind::ComputerPlayer.new
game = Mastermind::Game.new(player, computer)

game.play
