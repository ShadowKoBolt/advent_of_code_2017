module Checksum
  extend self

  def call(path_to_file)
    File.open(path_to_file).map do |line|
      line.gsub(/[\n]/, '')
    end.map do |line_without_garbage|
      line_without_garbage.split(' ')
    end.map do |line_of_numbers|
      line_of_numbers.map(&:to_i)
    end.map do |array_of_integers|
      first_evenly_divisible_values(array_of_integers)
    end.sum
  end

  module_function :call

  def first_evenly_divisible_values(array)
    array.permutation(2).each do |pair|
      return pair[0]/pair[1] if (pair[0] % pair[1]) == 0
    end
  end

end

raise(StandardError, 'Result should eq 18') unless Checksum.call('./day2_part2_example_input') == 9
