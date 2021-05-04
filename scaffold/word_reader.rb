class WordReader
  attr_reader :word, :alphabet

  def initialize(language, printer)
    @printer = printer
    @language = language
end

def select_language
  loop do
    @printer.cls
    @printer.show_header
    puts "\nChoose a dictionary (input one number):\n\n"
    @language.each_key do |k| 
      puts "[#{k}] - #{@language[k][:name]}"
    end
    print "\n> "
    choise = gets.chomp.to_sym
    if @language.include?(choise)
      @alphabet = @language[choise][:alphabet]
      @dictionary_file = @language[choise][:dict]
      @word = get_word_from_file
      break
    end
  end
end

def get_word_from_file
  path = File.dirname(__FILE__)
  filename = "#{path}/data/#{@dictionary_file}"
  print "Load file #{filename}... "
  dictionary = []
  File.open(filename).readlines.each do |word|
    word.gsub!(/\r\n/, "")
    dictionary << word if word.size.between?(3, 7)
  end
  sleep 0.5
  puts '[OK]'
  sleep 0.5
  dictionary.sample
end
end