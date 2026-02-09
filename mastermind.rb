# frozen_string_literal: true

# OBJECTIVE: MASTERMIND.

# CRITERIA:
# 1. COMPUTER RANDOMLY SELECTS SECRET COLORS. HUMAN PLAYER MUST GUESS THEM. FEEDBACK BASED ON HOW GOOD GUESS WAS
# 2. AFTER COMPLETE FIRST GOAL, ALLOW HUMAN PLAYER TO SELECT IF THEY ARE CODEBREAKER OR MASTERMIND
# 3. ADD COMPUTER ALOGIRTHM FOR GUESSING
# 4. IMPLEMENT COMPUTER ALGORITHM WITH OPTIMAL MASTERMIND STRATEGY

require_relative 'lib/player'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require_relative 'lib/game'

player = Mastermind::HumanPlayer.new
computer = Mastermind::ComputerPlayer.new
game = Mastermind::Game.new(player, computer, interactive: false)

game.start
