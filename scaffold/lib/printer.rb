# frozen_string_literal: true

#  class for output information to terminal
class Printer
  def initialize(width, screen_file)
    @width = width
    filename = "#{$path}/data/#{screen_file}"
    @pictures = File.open(filename).read.split(';').filter { |screen| screen != '' }
  end

  def cls
    system 'clear'
  end

  def intro
    cls
    show_header
    text = %q(
Welcome to the classic Russian linguistic fun.

I will make a word from 3 to 7 letters.
Try to guess it all.
You have the opportunity to make mistakes
up to 7 times or you will end up on the SCAFFOLD.

The game has the option to choose from dictionaries:
  Russian
  English.

GOOD LUCK!

Press the Enter...)
    print text
    _ = gets
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
    puts 'SCAFFOLD (0.2)'.center(@width)
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
