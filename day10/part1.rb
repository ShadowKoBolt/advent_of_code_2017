module KnotHash
  def call(list, input)
    skip_size = 0
    position = 0
    input.split(/, ?/).map(&:to_i).each do |length|
      list.rotate!(position)
      section = list.shift(length)
      list = section.reverse + list
      list.rotate!(-position)
      position += (length + skip_size)
      skip_size += 1
    end
    list.shift(2).inject(:*)
  end

  module_function :call
end

puts KnotHash.call((0..4).to_a, '3, 4, 1, 5')
puts KnotHash.call((0..255).to_a,
                   '63,144,180,149,1,255,167,84,125,65,188,0,2,254,229,24')
