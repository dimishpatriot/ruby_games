# frozen_string_literal: true

require 'set'

# all logic is here
class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters

  def initialize(word)
    # vars
    @errors = 0
    @good_letters = Set.new
    @bad_letters = Set.new
    @letters = word.upcase.split('')
  end

  def next_step
    current_letter = user_input
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

  def user_input
    loop do
      puts
      print 'input one letter: '
      letter = $stdin.gets.chomp.upcase
      return letter if ('A'..'Z').include?(letter) && letter.size == 1
    end
  end

  def win?
    @letters.to_set == @good_letters.to_set
  end

  def letter_incorrect?(current_letter)
    !@letters.include?(current_letter)
  end
end
