# frozen_string_literal: true

# ROBOT'S DRIBBLING
# Training for good OOP

# doc
class Subject
  attr_accessor :x, :y, :number, :score

  def initialize(options = {})
    @field = options[:field]
    @x = options[:x] || @field[:size_x] / 2
    @y = options[:y] || @field[:size_y] / 2
    @number = options[:number]
    @score = 0
  end

  def right
    @x < (@field[:size_x] - 1) and @x += 1
  end

  def left
    @x.positive? and @x -= 1
  end

  def up
    @y < @field[:size_y] - 1 and @y += 1 or (
      @score += 1
      down
    )
  end

  def down
    @y.positive? and @y -= 1 or (
      @score += 1
      up
    )
  end
end

# doc
class Robot < Subject
  attr_accessor :energy

  def initialize(options = {})
    super
    @energy = 100
    @x = options[:x] || options[:field][:size_x] / 2
    @y = options[:y] || options[:field][:size_y] / 2
  end

  def label
    '*'
  end

  def may_power_up?
    @x.zero? || @x == @field[:size_x] - 1
  end

  def go
    return unless energy.positive?

    m = %i[right left up down].sample
    send(m)
    sleep 0.01
    @energy -= 1
  end

  def charge_up
    m = %i[right left].sample
    send(m)
    sleep 0.01
    @energy += 20
  end
end

# doc
class Predator < Subject
  def initialize(options = {})
    super
    @x = rand(0..(options[:field][:size_x] - 1))
    @y = rand(0..(options[:field][:size_y] - 1))
  end

  def label
    '@'
  end

  def eat; end
end

# doc
class Commander
  def initialize(options = {})
    @army = []
    @enemies = []
    @field = options[:field]
    @screen = Screen.new(field: @field)
    @step = 0
    @max_steps = options[:max_steps]
  end

  def create_army(army_size)
    @army = (1..army_size).map do |num|
      Robot.new(number: num, field: @field)
    end
  end

  def add_enemies(count)
    @enemies = (1..count).map do |num|
      Predator.new(number: num, field: @field)
    end
  end

  def start_battle
    (0..@max_steps).each do |step|
      if @army.max_by(&:energy).energy.positive?
        @screen.show_all(army: @army, enemies: @enemies, steps: { current_step: step, max_steps: @max_steps })
        move_on
      else
        puts 'Energy LOW - GAME OVER'
        exit
      end
    end
  end

  def move_on
    @army.each do |robot|
      if @enemies.find { |enemy| robot.x == enemy.x && robot.y == enemy.y }
        @army.delete(robot)
      else
        robot.may_power_up? and robot.charge_up or robot.go
      end
    end
  end
end

# doc
class Screen
  def initialize(options = {})
    @field = options[:field]
    @size_x = @field[:size_x]
    @size_y = @field[:size_y] + 4
  end

  def show_all(options = {})
    @army = options[:army]
    @enemies = options[:enemies]
    clear_all

    show_header(options[:steps])
    show_field
    show_footer

    top_list = get_top(options[:army], 5)
    show_top(top_list)
  end

  def get_top(army, top_list_size)
    sorter = army.dup
    top = []
    top_list_size.times do
      robot = sorter.max_by(&:score)
      return top unless robot&.score&.positive?

      top.push(robot)
      sorter.delete(robot)
    end
    top
  end

  def show_header(options = {})
    puts "Step: #{options[:current_step]} of #{options[:max_steps]}"
    puts "Robots on field: #{@army.size}"
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
    return unless top_list.size.positive?

    puts '-- TOP LIST --'.center(@size_x)
    puts "Number\tScores\tEnergy"
    top_list.each do |e|
      puts "##{e.number}\t#{e.score}\t#{e.energy.positive? ? e.energy : '--'}"
    end
  end

  def show_field
    (@field[:size_y] - 1).downto(0) do |y|
      0.upto(@field[:size_x]) do |x|
        subject = @enemies.find { |s| s.x == x && s.y == y } || @army.find { |s| s.x == x && s.y == y }
        show_subject(subject, { x: x, y: y })
      end
      puts
    end
  end

  def show_subject(subject, coord)
    if subject
      print subject.label
    else
      [0, @field[:size_x] - 1].include?(coord['x']) and print '.' or print ' '
    end
  end
end

# === MAIN ===
field = { size_x: 20, size_y: 10 }
commander = Commander.new(field: field, max_steps: 1000)
commander.create_army(24)
commander.add_enemies(4)
commander.start_battle
