module Checksum
  def call(path_to_file)
    File.open(path_to_file).map do |line|
      line.gsub(/[\n]/, '')
    end.map do |line_without_garbage|
      line_without_garbage.split(' ')
    end.map do |line_of_numbers|
      line_of_numbers.map(&:to_i)
    end.map do |array_of_integers|
      array_of_integers.max - array_of_integers.min
    end.sum
  end

  module_function :call
end

raise(StandardError, 'Result should eq 18') unless Checksum.call('./day2_example_input') == 18
