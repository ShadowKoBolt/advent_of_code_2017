Examples = %w[1212 1221 123425 123123 12131415]
Results = [6, 0, 4, 12, 4]

module Captcha
  def call(input)
    chars = input.to_s.chars
    chars.length.times.map do |i|
      rotated_chars = chars.rotate(i)
      rotated_chars[0] == rotated_chars[chars.length/2] ? rotated_chars[0].to_i : 0
    end.sum
  end

  module_function :call
end

Examples.each_with_index do |example, i|
  raise(StandardError, "#{example} should eql #{i}") unless Captcha.call(example) == Results[i]
end
