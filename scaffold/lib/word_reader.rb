# frozen_string_literal: true

# class for reading word
class WordReader
  attr_reader :alphabet

  def initialize(language, choise)
      @alphabet = language[choise][:alphabet]
      @dictionary_file = language[choise][:dict]
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
