class MemoryBalancer
  def initialize(string)
    @string = string
  end

  def cycle_count
    blocks = format_string_as_integer_array
    seen_before = []
    until seen_before.include?(blocks)
      seen_before << blocks.dup
      blocks = run_cycle(blocks)
    end
    seen_before << blocks
    seen_before.rindex(blocks) - seen_before.find_index(blocks)
  end

  private

  def format_string_as_integer_array
    @string.split(/\t/).map(&:to_i)
  end

  def run_cycle(blocks)
    index_to_reallocate = blocks.find_index(blocks.max)
    block_value = blocks[index_to_reallocate]
    blocks[index_to_reallocate] = 0
    block_value.times do |count|
      blocks = blocks.rotate(count + 1)
      blocks[index_to_reallocate] += 1
      blocks = blocks.rotate(-(count + 1))
    end
    blocks
  end
end

unless MemoryBalancer.new('0	2	7	0').cycle_count == 4
  raise StandardError, 'Result should eq 4'
end
