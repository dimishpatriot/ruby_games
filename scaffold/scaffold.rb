# frozen_string_literal: true

# scaffold v.0.1

require_relative 'word_reader'
require_relative 'game'
require_relative 'printer'

# main ----------------------------------------------------

printer = Printer.new(60, 'screens.txt')
printer.intro

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

reader = WordReader.new(language, printer)
reader.select_language

game = Game.new(reader.word, reader.alphabet)

while game.errors < 7
  printer.show_screen(game)
  game.next_step
  break if game.win?
end

printer.show_final(game)
