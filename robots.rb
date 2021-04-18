# ROBOT'S DRIBBLING
# Training for good OOP
class Robot
  attr_accessor :x, :y, :number, :score, :energy

  def initialize(options = {})
    @field = options[:field]
    @x = options[:x] || @field[:size_x] / 2
    @y = options[:y] || @field[:size_y] / 2
    @number = options[:number]
    @score = 0
    @energy = 100
  end

  def right
    if @x < @field[:size_x] - 1
      @x += 1
    else
      @energy += 25
      left
    end
  end

  def left
    if @x > 0
      @x -= 1
    else
      @energy += 25
      right
    end
  end

  def up
    if @y < @field[:size_y] - 1
      @y += 1
    else
      @score += 1
      down
    end
  end

  def down
    if @y > 0
      @y -= 1
    else
      @score += 1
      up
    end
  end
end

class Commander
  def initialize(options = {})
    @army = []
    @field = options[:field]
    @screen = Screen.new(field: @field)
    @step = 0
    @max_steps = options[:max_steps]
  end

  def create_army(army_size)
    @army = (0..army_size).map do |num|
      Robot.new(number: num, field: @field)
    end
  end

  def start_battle
    (0..@max_steps).each do |step|
      if (@army.max_by { |robot| robot.energy }).energy > 0
        @screen.show_all(
          army: @army,
          steps: { current_step: step, max_steps: @max_steps }
        )
        move_robots
      else
        puts 'Energy LOW - GAME OVER'
        exit
      end
    end
  end

  def move_robots
    @army.each do |robot|
      if robot.energy > 0
        m = %i[right left up down].sample
        robot.send(m)
        robot.energy -= 1
      end
      sleep 0.01
    end
  end
end

class Screen
  def initialize(options = {})
    @field = options[:field]
    @size_x = @field[:size_x]
    @size_y = @field[:size_y] + 4
  end

  def show_all(options = {})
    clear_all

    show_header(options[:steps])
    show_field(options[:army])
    show_footer

    top_list = get_top(options[:army], 10)
    show_top(top_list)
  end

  def get_top(army, top_list_size)
    sorter = army.dup
    top = []
    top_list_size.times do
      robot = sorter.max_by { |e| e.score }
      if robot.score > 0
        top.push(robot)
        sorter.delete(robot)
      else
        return top
      end
    end
    top
  end

  def show_header(options = {})
    puts "Step: #{options[:current_step]} of #{options[:max_steps]}"
    print '/'
    print '-' * (@size_x - 2)
    puts '\\'
  end

  def show_footer
    print '\\'
    print '-' * (@size_x - 2)
    puts '/'
  end

  def clear_all
    puts "\e[H\e[2J"
  end

  def show_top(top_list)
    if top_list.size > 0
      puts '-- TOP LIST --'.center(@size_x)
      puts "Number\tScores\tEnergy"
      top_list.each do |e|
        puts "##{e.number}\t#{e.score}\t#{e.energy}"
      end
    end
  end

  def show_field(army)
    (@field[:size_y] - 1).downto(0) do |y|
      0.upto(@field[:size_x]) do |x|
        if army.any? { |robot| robot.x == x && robot.y == y }
          print '*'
        elsif [0, @field[:size_x] - 1].include?(x)
          print '.'
        else
          print ' '
        end
      end
      puts
    end
  end
end

# === MAIN ===
field = { size_x: 20, size_y: 10 }
commander = Commander.new(
  field: field,
  max_steps: 1000
)
commander.create_army(army_size = 24)
commander.start_battle
exit