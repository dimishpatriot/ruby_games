# frozen_string_literal: true

require_relative 'lib/word_reader'
require_relative 'lib/game'
require_relative 'lib/printer'

# var -----------------------------------------------------
version = '0.2.2'
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

choise = nil
loop do
  printer.show_lang_list(language)
  choise = gets.chomp.to_sym
  next unless language.include?(choise)
  break
end
reader = WordReader.new(language, choise)

game = Game.new(reader.word_from_file, reader.alphabet)

while game.errors < 7
  printer.show_screen(game)
  game.next_step
  break if game.win?
end

printer.show_final(game)
