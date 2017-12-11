class KnotHash
  SUFFIX = [17, 31, 73, 47, 23]

  class << self
    def call(string)
      new.call(string)
    end
  end

  def initialize
    @list = (0..255).to_a
    @skip_size = 0
    @position = 0
  end

  def call(input)
    lengths = string_to_ascii_array(input) + SUFFIX
    64.times do
      round(lengths)
    end
    dense_hash(@list).map do |int|
      "%02x" % int
    end.join
  end

  private

  def string_to_ascii_array(string)
    string.chars.map(&:ord)
  end

  def round(lengths)
    lengths.each do |length|
      @list.rotate!(@position)
      section = @list.shift(length)
      @list = section.reverse + @list
      @list.rotate!(-@position)
      @position += (length + @skip_size)
      @skip_size += 1
    end
  end

  def dense_hash(array)
    array.each_slice(16).map do |slice|
      slice.reduce(:^)
    end
  end
end

puts KnotHash.call('')         == 'a2582a3a0e66e6e86e3812dcb672a272'
puts KnotHash.call('AoC 2017') == '33efeb34ea91902bb2f59c9920caa6cd'
puts KnotHash.call('1,2,3')    == '3efbe78a8d82f29979031a4aa0b16a9d'
puts KnotHash.call('1,2,4')    == '63960835bcdc130f0b66d7ff4f6a5a8e'
puts KnotHash.call('63,144,180,149,1,255,167,84,125,65,188,0,2,254,229,24')
