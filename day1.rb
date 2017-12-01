Examples = %w[1122 1111 1234 91212129]
Results = [3, 4, 0, 9]

module Captcha
  def call(input)
    chars = input.to_s.chars
    (-1..(chars.length-1)).map do |i|
      chars[i] == chars[i+1] ? chars[i].to_i : 0
    end.sum
  end

  module_function :call
end

Examples.each_with_index do |example, i|
  puts Captcha.call(example) == Results[i]
end
