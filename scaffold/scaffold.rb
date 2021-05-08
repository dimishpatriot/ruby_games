# frozen_string_literal: true

require_relative 'lib/word_reader'
require_relative 'lib/game'
require_relative 'lib/printer'

# var -----------------------------------------------------
version = '0.2.3'
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

reader = WordReader.new(language) { printer.show_lang_list(language) }

loop do
  game = Game.new(reader.word_from_file, reader.alphabet)
  while game.errors < 7
    game.next_step { printer.show_screen(game) }
    break if game.win?
  end
  printer.show_final(game)

  print 'Play again? (Y/any) '
  break unless gets.chomp.upcase == 'Y'
end

printer.show_outro
