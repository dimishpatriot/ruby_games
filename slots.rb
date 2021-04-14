class SlotGame

  def initialize
    @cw = 36

    puts '=======  < CASINO ROYALE >  ========'.center(@cw)
    show_intro
    until user_is_amateur?
      puts 'Sorry, you are so young. Bay-bay..'.center(@cw)
      get_out
    end

    @start_balance = input_money
    until @start_balance > 0
      puts 'You are empty :( Go home!'.center(@cw)
      get_out
    end

    puts '-' * @cw
    puts '>> Welcome! <<'.center(@cw)
    @escape_rate = 2.5
    @round_pay = @start_balance / 20
    puts "Escape balance:  #{@start_balance * @escape_rate}$ or more"
    sleep 2
  end

  def input_money
    print '> Input your money: '
    gets.to_f
  end

  def show_intro
    puts 'Angry slots machine table:'
    puts "one round   => -0.5$"
    puts 'X - X - ANY => free roll'
    puts '0 - 0 - 0   => loose immediately'
    puts "1 - 1 - 1   => you win 10$"
    puts "2 - 2 - 2   => you win 10$"
    puts "3 - 3 - 3   => you win 20$"
    puts "4 - 4 - 4   => you win 50$"
    puts "5 - 5 - 5   => you win 100$"
    puts 'Escape balance = start balance x 3'
    puts '-' *@cw
  end

  def user_is_amateur?
    print '> Input your age:   '
    if gets.to_i < 18
      false
    else
      true
    end
  end

  def get_rand_num
    rand(0..5)
  end

  def check_paytable
    if @first_num == @second_num
      if @second_num == @third_num
        case @first_num
          when 0
            return -100
          when 1 || 2
            return 10
          when 3
            return 20
          when 4
            return 50
          when 5
            return 100
        end
      else
        return 0  # free roll
      end
    end
    -0.5
  end

  def game_over?
    if @balance <= 0
      puts 'You have no money - You LOSE!'.center(@cw)
      true
    elsif @balance >= @start_balance * @escape_rate
      puts '\**+**/  You WIN  \**+**/'.center(@cw)
      show_final_result
      true
    else
      false
    end
  end

  def get_out
      puts '=' * @cw
      exit
  end

  def show_final_result
    puts '-' * @cw
    puts "Start balance: #{@start_balance}"
    puts "Final balance: #{@balance}"
    win = @balance - @start_balance
    puts "You win:       #{win}"
    puts "ROI:           #{(win.to_f / @start_balance).round(2)}"
  end

  def start
    @balance = @start_balance
    puts 'Go-go-go!...'.center(@cw)
    counter = 1
    loop do
      @first_num = get_rand_num
      @second_num = get_rand_num
      @third_num = get_rand_num

      puts "Round ##{counter.to_s.ljust(4, ' ')}#{@balance.to_s.rjust(6, ' ')}$   >  #{@first_num} - #{@second_num} - #{@third_num}  <"

      you_win = check_paytable
      case you_win
        when -100
          puts '-- 0-0-0 ...Bad day for you... --'.center(@cw)
          sleep 1
          @balance = 0
        when 0
          puts '+ free roll +'.center(@cw)
          sleep 1
        else
          if you_win > 0
            puts "++ WOW +#{you_win}$! ++".center(@cw)
            sleep 1
          end
          @balance += you_win
          sleep 0.25
      end

      if game_over?
        get_out
      end
      counter += 1
    end
  end
end

game = SlotGame.new
game.start