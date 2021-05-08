# frozen_string_literal: true

#  class for output information to terminal
class Printer
  def initialize(width, version)
    @width = width
    @version = version
    filename = './data/screens.txt'
    @pictures = File.open(filename).read.split(';').filter { |screen| screen != '' }
  end

  def cls
    system 'clear'
  end

  def intro
    cls
    show_header
    File.open('./data/intro.txt').readlines.each { |line| puts line }
    _ = gets
  end

  def show_lang_list(language)
    cls and show_header
    puts "\nChoose a dictionary (input one number):\n\n"
    language.each_key { |k| puts "[#{k}] - #{language[k][:name]}\n\n" }
  end

  def show_screen(game = {})
    cls
    show_header
    show_scaffold(game.errors)
    show_word(game.letters, game.good_letters)
    show_stat(game.good_letters, game.bad_letters, game.errors)
  end

  def show_final(game = {})
    show_screen(game)
    puts '-' * @width
    if game.errors == 7
      puts '--- You LOSE ---'.center(@width)
    else
      puts '+++ You WIN +++'.center(@width)
    end
    puts "the word is '#{game.letters.join.upcase}'"
    puts '-' * @width
  end

  def show_header
    puts '-' * @width
    puts "SCAFFOLD (#{@version})".center(@width)
    puts '-' * @width
  end

  def show_stat(good_letters, bad_letters, errors)
    puts "good letters #{good_letters.join(', ')}"
    puts "bad letters  #{bad_letters.join(', ')}"
    puts "errors: #{errors} of 7"
  end

  def show_word(letters, good_letters)
    word = []
    letters.each do |letter|
      word << if good_letters.include?(letter)
                letter
              else
                '*'
              end
    end
    puts "--> #{word.join(' ')} <--\n".center(@width)
  end

  def show_scaffold(num_errors)
    screen = @pictures[num_errors].split(/\n/)
    screen.each { |line| puts line.center(@width) }
  end
end
