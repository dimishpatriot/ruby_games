# frozen_string_literal: true

# class for reading word
class WordReader
  attr_reader :word, :alphabet

  def initialize(language, printer)
    loop do
      show_list(language, printer)
      choise = gets.chomp.to_sym
      next unless language.include?(choise)

      @alphabet = language[choise][:alphabet]
      @dictionary_file = language[choise][:dict]
      @word = word_from_file
      break
    end
  end

  def show_list(language, printer)
    printer.cls and printer.show_header
    puts "\nChoose a dictionary (input one number):\n\n"
    language.each_key { |k| puts "[#{k}] - #{language[k][:name]}\n\n" }
  end

  def word_from_file
    filename = "./data/#{@dictionary_file}"
    dictionary = []
    File.open(filename).readlines.each do |word|
      word.gsub!(/\r\n/, '')
      dictionary << word if word.size.between?(3, 7)
    end
    dictionary.sample
  end
end
