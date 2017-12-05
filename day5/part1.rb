example = [0, 3, 0, 1, -3]

module JumpCounter
  def call(instructions)
    counter = 0
    current_index = 0
    until instructions[current_index].nil?
      previous_index = current_index
      current_index = previous_index + instructions[current_index]
      instructions[previous_index] += 1
      counter += 1
    end
    counter
  end

  module_function :call
end

raise(StandardError, 'example failed') unless JumpCounter.call(example) == 5

input = File.open('./input').map(&:chomp).map(&:to_i).to_a
puts JumpCounter.call(input)
