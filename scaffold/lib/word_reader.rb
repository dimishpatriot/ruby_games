# frozen_string_literal: true

# class for reading word
class WordReader
  attr_reader :alphabet, :word

  def initialize(language)
    loop do
      yield(language) if block_given? # print languages list
      @choise = gets.chomp.to_sym
      break if language.keys.include?(@choise)
    end
    @alphabet = language[@choise][:alphabet]
    @dictionary_file = language[@choise][:dict]
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
