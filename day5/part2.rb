example = [0, 3, 0, 1, -3]

module JumpCounter
  def call(instructions)
    counter = 0
    current_index = 0
    until instructions[current_index].nil?
      previous_index = current_index
      current_index = previous_index + instructions[current_index]
      adjust_offset(instructions, previous_index)
      counter += 1
    end
    counter
  end

  module_function :call

  class << self
    def adjust_offset(instructions, index)
      if instructions[index] >= 3
        instructions[index] -= 1
      else
        instructions[index] += 1
      end
    end

    private :adjust_offset
  end
end

raise(StandardError, 'example failed') unless JumpCounter.call(example) == 10

input = File.open('./input').map(&:chomp).map(&:to_i).to_a
puts JumpCounter.call(input)
