# frozen_string_literal: true

# scaffold v.0.1

require_relative 'game'
require_relative 'printer'

# main ----------------------------------------------------
game = Game.new
printer = Printer.new
while game.errors < 7
  printer.show_screen(game)
  game.next_step
  break if game.win?
end

printer.show_final(game)
