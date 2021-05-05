# frozen_string_literal: true

require_relative 'lib/word_reader'
require_relative 'lib/game'
require_relative 'lib/printer'

# var -----------------------------------------------------
version = '0.2.1'
language = {
  '1': {
    name: 'Russian words',
    dict: 'ruswords.txt',
    alphabet: ('А'..'Я')
  },
  '2': {
    name: 'English words',
    dict: 'engwords.txt',
    alphabet: ('A'..'Z')
  }
}

# main ----------------------------------------------------
printer = Printer.new(60, version)
printer.intro


reader = WordReader.new(language, printer)

game = Game.new(reader.word, reader.alphabet)

while game.errors < 7
  printer.show_screen(game)
  game.next_step
  break if game.win?
end

printer.show_final(game)
