class WordReader
  def initialize(dictionary_file)
    path = File.dirname(__FILE__)
    @filename = "#{path}/data/#{dictionary_file}"
  end

  def get_word_from_file
  dictionary = []
  File.open(@filename).readlines.each do |word|
    word.gsub!(/\r\n/, "")
    dictionary << word if word.size.between?(3, 7)
  end
  dictionary.sample
end
end