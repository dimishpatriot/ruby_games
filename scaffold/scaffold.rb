# frozen_string_literal: true

# scaffold v.0.1

require_relative 'word_reader'
require_relative 'game'
require_relative 'printer'

# main ----------------------------------------------------
reader = WordReader.new('engwords.txt')
game = Game.new(reader.get_word_from_file)
printer = Printer.new(60, 'screens.txt')
while game.errors < 7
  printer.show_screen(game)
  game.next_step
  break if game.win?
end

printer.show_final(game)
