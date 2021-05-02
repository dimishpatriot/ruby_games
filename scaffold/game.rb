require 'set'

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters

  def initialize
    # vars
    @errors = 0
    @good_letters = Set.new
    @bad_letters = Set.new
    @letters = get_letters(get_word_from_file)
  end

  def get_word_from_file
    dictionary = []
    File.open("engwords.txt", "r").readlines.each do |word|
      word.gsub!(/\r\n/, "")
      dictionary << word if word.size.between?(3,7)
    end
    dictionary.sample
  end


  def get_letters(word)
    return word.upcase.split('') until (word == nil || word == "")
  end

  def next_step
      current_letter = get_user_input
      if (@bad_letters + @good_letters).include?(current_letter)
        puts "~ you've already entered this letter"
      elsif letter_incorrect?(current_letter)
        @bad_letters << current_letter
        @errors += 1
        puts '- letter incorrect'
      else
        @good_letters << current_letter
        puts '+ letter is correct :)'
      end
      sleep 1.3
  end

  def get_user_input
      puts
      print 'input one letter: '
    begin
      letter = STDIN.gets.chomp.upcase
    end until letter in ('A'..'Z') and letter.size == 1
    letter
  end

  def win?
    return (@letters.to_set == @good_letters.to_set)
  end

  def letter_incorrect?(current_letter)
    !@letters.include?(current_letter)
  end
end
