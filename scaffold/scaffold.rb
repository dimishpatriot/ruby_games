# frozen_string_literal: true

# scaffold v.0.1

require_relative 'word_reader'
require_relative 'game'
require_relative 'printer'

# main ----------------------------------------------------

def select_language(printer)
language = {
  '1': {
    name: 'English words',
    dict: 'engwords.txt', 
    alphabet: ('A'..'Z')
  },
  '2': {
    name: 'Russian words',
    dict: 'ruswords.txt', 
    alphabet: ('А'..'Я')
  }
}
  loop do
    printer.cls
    printer.show_header
    puts
    puts 'choose a dictionary (input one number):'
    language.each_key do |k| 
      puts "[#{k}] - #{language[k][:name]}"
    end
    print '> '
    choise = gets.chomp.to_sym
    return choise, language[choise][:dict], language[choise][:alphabet] if language.include?(choise)
  end
end

printer = Printer.new(60, 'screens.txt')
choise, dict, alphabet = select_language(printer)
reader = WordReader.new(dict)
game = Game.new(reader.get_word_from_file, alphabet)

while game.errors < 7
  printer.show_screen(game)
  game.next_step
  break if game.win?
end

printer.show_final(game)
