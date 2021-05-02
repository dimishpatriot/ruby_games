# frozen_string_literal: true

#  class for outputing information to terminal
class Printer
  def cls
    system 'clear'
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
    puts '-' * 80
    if game.errors == 7
      puts '--- You LOSE ---'.center(80)
    else
      puts '+++ You WIN +++'.center(80)
    end
    puts "the word is '#{game.letters.join.upcase}'"
    puts '-' * 80
  end

  def show_header
    puts '-' * 80
    puts 'SCAFFOLD (0.1)'.center(80)
    puts '-' * 80
  end

  def show_stat(good_letters, bad_letters, errors)
    puts "good letters #{good_letters.join(', ')}"
    puts "bad letters  #{bad_letters.join(', ')}"
    puts "errors: #{errors} of 7"
  end

  def show_word(letters, good_letters)
    word = ''
    letters.each do |letter|
      word << if good_letters.include?(letter)
                letter
              else
                '*'
              end
      word << ' '
    end
    puts "-->  #{word} <--\n".center(80)
  end

  def show_scaffold(num_errors)
    picture = [
      ['              ', # 0
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '``````````````'],
      ['              ', # 1
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       ' ||           ',
       '``````````````'],
      ['              ', # 2
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       ' ||        || ',
       '``````````````'],
      ['              ', # 3
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       '              ',
       ' ==|========= ',
       ' ||        || ',
       '``````````````'],
      ['              ', # 4
       '              ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       ' ==|========= ',
       ' ||        || ',
       '``````````````'],
      ['              ', # 5
       '  ---------   ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       ' ==|========= ',
       ' ||        || ',
       '``````````````'],
      ['              ', # 6
       '  ---------   ',
       '   |      :   ',
       '   |      :   ',
       '   |      :   ',
       '   |      O   ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       '   |          ',
       ' ==|========= ',
       ' ||        || ',
       '``````````````'],
      ['              ', # 7
       '  ---------   ',
       '   |      :   ',
       '   |      :   ',
       '   |      :   ',
       '   |     (x)  ',
       '   |     _|_  ',
       '   |    / | \ ',
       '   |      |   ',
       '   |     / \  ',
       '   |    /   \ ',
       '   |          ',
       '   |          ',
       ' ==|========= ',
       ' ||        || ',
       '``````````````']
    ]
    picture[num_errors].each { |line| puts line.center(80) }
  end
end
