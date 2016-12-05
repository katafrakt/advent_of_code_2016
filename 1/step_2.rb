input = 'R4, R3, R5, L3, L5, R2, L2, R5, L2, R5, R5, R5, R1, R3, L2, L2, L1, R5, L3, R1, L2, R1, L3, L5, L1, R3, L4, R2, R4, L3, L1, R4, L4, R3, L5, L3, R188, R4, L1, R48, L5, R4, R71, R3, L2, R188, L3, R2, L3, R3, L5, L1, R1, L2, L4, L2, R5, L3, R3, R3, R4, L3, L4, R5, L4, L4, R3, R4, L4, R1, L3, L1, L1, R4, R1, L4, R1, L1, L3, R2, L2, R2, L1, R5, R3, R4, L5, R2, R5, L5, R1, R2, L1, L3, R3, R1, R3, L4, R4, L4, L1, R1, L2, L2, L4, R1, L3, R4, L2, R3, L1, L5, R4, R5, R2, R5, R1, R5, R1, R3, L3, L2, L2, L5, R2, L2, R5, R5, L2, R3, L5, R5, L2, R4, R2, L1, R3, L5, R3, R2, R5, L1, R3, L2, R2, R1'
control_input = 'R8, R4, R4, R8'

class Position
  DIRECTIONS = {
    n: [1, 0],
    e: [0, 1],
    s: [-1, 0],
    w: [0, -1]
  }

  attr_reader :current_position

  def initialize
    @current_position = [0, 0]
    @current_direction = :n
    @visited_locations = [[0,0]]
  end

  def go(input)
    steps = input.split(', ')
    steps.each do |step|
      direction, num = step.split('', 2)
      turn(direction)
      move(num.to_i)
      break if @finish
    end
  end

  def turn(direction)
    directions = DIRECTIONS.keys
    current_idx = directions.index(@current_direction)
    new_idx = direction == 'R' ? (current_idx + 1) % 4 : (current_idx - 1) % 4
    @current_direction = directions[new_idx]
  end

  def move(num)
    change = DIRECTIONS[@current_direction]
    num.times do
      @current_position[0] += change[0]
      @current_position[1] += change[1]
      check_current_location
      break if @finish
    end
  end

  def check_current_location
    @finish = true if @visited_locations.include?(@current_position)
    @visited_locations << @current_position.dup
  end
end

pos = Position.new
pos.go(input)
puts pos.current_position[0].abs + pos.current_position[1].abs
